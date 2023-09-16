//
//  EventsAPI.swift
//  CITRARB
//
//  Created by Richard Uzor on 12/09/2023.
//

import Foundation
import Combine
import UIKit

class EventsAPIClient: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    
    func fetchEventsList(completion: @escaping (Result<GetAllEvents, Error>) -> Void) {
        let urlString = "\(BASE_URL)events/"
        
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
                    print("Events List Response data: \(responseString)")
                } else {
                    print("Response data cannot be converted to a string.")
                }
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case to camelCase conversion if needed
                    let eventsListResponse = try decoder.decode(GetAllEvents.self, from: data)
                    completion(.success(eventsListResponse))
                    print("response: \(eventsListResponse)")
                    
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else {
                
                completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
            }
        }.resume()
        
    }
    
    
    enum EventsError: Error {
        case networkError(Error)
        case noData
        case decodingError(Error)
    }
    
    var uploadProgressPublisher = PassthroughSubject<Double, Never>()
    var uploadProgressHandler: ((Double) -> Void)?


    
    private var cancellables: Set<AnyCancellable> = []

    let boundary: String = "Boundary-\(UUID().uuidString)"
    let url: URL = URL(string: "\(BASE_URL)events/")!



    func uploadFile(selectedFile1: UIImage?, name: String, description: String, location: String, time: String,progressHandler: @escaping (Double) -> Void,
                    completion: @escaping (Result<CreateEventResponse, EventsError>) -> Void) {

        let imageArray: [UIImage] = [
            selectedFile1!,
            ]

        let requestBody = self.multipartFormDataBody(self.boundary, name, location, description, time, imageArray)
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

    private func multipartFormDataBody(_ boundary: String, _ name: String, _ location: String, _ description: String, _ time: String, _ images: [UIImage]) -> Data {

          let lineBreak = "\r\n"
          var body = Data()

          body.append("--\(boundary + lineBreak)")
          body.append("Content-Disposition: form-data; name=\"name\"\(lineBreak + lineBreak)")
          body.append("\(name + lineBreak)")

          body.append("--\(boundary + lineBreak)")
          body.append("Content-Disposition: form-data; name=\"location\"\(lineBreak + lineBreak)")
          body.append("\(location + lineBreak)")

          body.append("--\(boundary + lineBreak)")
          body.append("Content-Disposition: form-data; name=\"description\"\(lineBreak + lineBreak)")
          body.append("\(description + lineBreak)")

          body.append("--\(boundary + lineBreak)")
          body.append("Content-Disposition: form-data; name=\"time\"\(lineBreak + lineBreak)")
          body.append("\(time + lineBreak)")

          for image in images {
              if let uuid = UUID().uuidString.components(separatedBy: "-").first {
                  body.append("--\(boundary + lineBreak)")
                  body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(uuid).jpg\"\(lineBreak)")
                  body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
                  body.append(image.jpegData(compressionQuality: 0.99)!)
                  body.append(lineBreak)
              }
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
