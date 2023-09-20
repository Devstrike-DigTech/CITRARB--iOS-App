//
//  ConnectsAPI.swift
//  CITRARB
//
//  Created by Richard Uzor on 04/09/2023.
//

import Foundation

class ConnectAPIClient{
    
    enum ConnectError: Error {
        case networkError(Error)
        case noData
        case decodingError(Error)
    }
    
    func fetchConnectsList(completion: @escaping (Result<ConnectResponse, Error>) -> Void) {
        let urlString = "\(BASE_URL)occupations"
        
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
                    print("Connect List Response data: \(responseString)")
                } else {
                    print("Response data cannot be converted to a string.")
                }
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case to camelCase conversion if needed
                    let connectsListResponse = try decoder.decode(ConnectResponse.self, from: data)
                    completion(.success(connectsListResponse))
                    print("response: \(connectsListResponse)")
                    
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else {
                
                completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
            }
        }.resume()
        
    }
    
    
    
    
    func createNewConnect(jobTitle: String, description: String, phone: String, name: String, category: String, completion: @escaping (Result<NewConnectResponse, ConnectError>) -> Void)  {
        let url = URL(string: "\(BASE_URL)occupations")! // Replace with your API URL

        print("making create connect api call...")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Add the bearer token

        let body: [String: AnyHashable] = [
            "jobTitle": jobTitle,
            "description": description,
            "phone": phone,
            "name": name,
            "category": category
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            if let error = error {
                completion(.failure(error as! ConnectAPIClient.ConnectError))
                           return
                       }
                       
                       guard let data = data else {
                           completion(.failure(.noData))
                           return
                       }
                       
                       do {
                           let response = try decoder.decode(NewConnectResponse.self, from: data)
                           
                           let createdOccupation = response.data

                           print("createdOccupation: \(createdOccupation)")
                           completion(.success(response))

                       } catch let decodingError as DecodingError {
                           print("Decoding error: \(decodingError)")
                           completion(.failure(.decodingError(decodingError)))
                       }catch {
                           // Handle other non-decoding errors
                           print("Error: \(error)")
                       }
            
        }
        task.resume()
    }
     
    func updateConnect(occupationId: String, jobTitle: String, description: String, phone: String, name: String, category: String, completion: @escaping (Result<NewConnectResponse, ConnectError>) -> Void)  {
        let url = URL(string: "\(BASE_URL)occupations/\(occupationId)")! // Replace with your API URL

        print("making create connect api call...")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Add the bearer token

        let body: [String: AnyHashable] = [
            "jobTitle": jobTitle,
            "description": description,
            "phone": phone,
            "name": name,
            "category": category
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            if let error = error {
                completion(.failure(error as! ConnectAPIClient.ConnectError))
                           return
                       }
                       
                       guard let data = data else {
                           completion(.failure(.noData))
                           return
                       }
                       
                       do {
                           let response = try decoder.decode(NewConnectResponse.self, from: data)
                           
                           let createdOccupation = response.data

                           print("createdOccupation: \(createdOccupation)")
                           completion(.success(response))

                       } catch let decodingError as DecodingError {
                           print("Decoding error: \(decodingError)")
                           completion(.failure(.decodingError(decodingError)))
                       }catch {
                           // Handle other non-decoding errors
                           print("Error: \(error)")
                       }
            
        }
        task.resume()
    }
    
}
