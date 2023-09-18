//
//  EyeWitnessAPI.swift
//  CITRARB
//
//  Created by Richard Uzor on 16/09/2023.
//

import Foundation
import Combine
import UIKit

class EyeWitnessAPIClient: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    func fetchReportsList(userId: String, completion: @escaping (Result<GetAllEyeWitnessResponse, Error>) -> Void) {
        var urlString = ""
        if userId == ""{
            urlString = "\(BASE_URL)eye_witness/"
        }else{
            urlString = "\(BASE_URL)eye_witness/?userId=\(userId)"
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Add the bearer token
        print(token)
        
        //if let url = URL(string: urlString)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            
            
            if let data = data {
                print(data)
                // Convert the data to a string and print it
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Reports List Response data: \(responseString)")
                } else {
                    print("Response data cannot be converted to a string.")
                }
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case to camelCase conversion if needed
                    let reportsListResponse = try decoder.decode(GetAllEyeWitnessResponse.self, from: data)
                    completion(.success(reportsListResponse))
                    print("response: \(reportsListResponse)")
                    
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else {
                
                completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
            }
        }.resume()
        
    }
    
    
    func deleteReport(reportId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
            let urlString = "\(BASE_URL)eye_witness/\(reportId)"
       
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Add the bearer token
        print(token)
        
        //if let url = URL(string: urlString)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            
            
            if let data = data {
                print(data)
                // Convert the data to a string and print it
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Eyewitness Report Delete Response data: \(responseString)")
                } else {
                    print("Response data cannot be converted to a string.")
                }
                do {
//                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case to camelCase conversion if needed
//                    let musicListResponse = try decoder.decode(GetAllMusicResponse.self, from: data)
//                    completion(.success(musicListResponse))
                    print("response: success")
                    
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else {
                
                completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
            }
        }.resume()
        
    }
    
    
    
    enum EyeWitnessError: Error {
        case networkError(Error)
        case noData
        case decodingError(Error)
    }
    
    var uploadProgressPublisher = PassthroughSubject<Double, Never>()
    var uploadProgressHandler: ((Double) -> Void)?
    
    
    
    private var cancellables: Set<AnyCancellable> = []
    
    let boundary: String = "Boundary-\(UUID().uuidString)"
    let url: URL = URL(string: "\(BASE_URL)eye_witness/")!
    
    
    
    func uploadFile(selectedFile1: UIImage?, name: String, location: String, videoFile: Data, progressHandler: @escaping (Double) -> Void,
                    completion: @escaping (Result<CreateEyeWitnessReport, EyeWitnessError>) -> Void) {
        
        
        
        let requestBody = self.multipartFormDataBody(self.boundary, name, location, selectedFile1!, videoFile)
        let request = self.generateRequest(httpBody: requestBody)
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            print(token)
            
            if let error = error {
                print(error)
                return
            }
            if let response = resp{
                print(response)
            }
            
            print("success")
        }.resume()
    }
    
    
    private func generateRequest(httpBody: Data) -> URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("multipart/form-data; boundary=" + self.boundary, forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Add the bearer token
        
        return request
    }
    
    private func multipartFormDataBody(_ boundary: String, _ name: String, _ location: String, _ images: UIImage, _ videoFile: Data) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"title\"\(lineBreak + lineBreak)")
        body.append("\(name + lineBreak)")
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"location\"\(lineBreak + lineBreak)")
        body.append("\(location + lineBreak)")
        
        
        if let uuid = UUID().uuidString.components(separatedBy: "-").first {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"images\"; filename=\"\(uuid).jpg\"\(lineBreak)")
            body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
            body.append(images.jpegData(compressionQuality: 0.99)!)
            body.append(lineBreak)
            
        }
        if let uuid = UUID().uuidString.components(separatedBy: "-").first {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"video\"; filename=\"\(uuid).mp4\"\(lineBreak)")
            body.append("Content-Type: video/mp4\(lineBreak + lineBreak)")
            body.append(videoFile)
            body.append(lineBreak)
            //}
        }
        
        body.append("--\(boundary)--\(lineBreak)") // End multipart form and return
        return body
    }
    
    
    // Implement URLSessionTaskDelegate methods to monitor progress
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        uploadProgressHandler?(progress)
    }
}
