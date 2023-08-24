//
//  MembersAPI.swift
//  CITRARB
//
//  Created by Richard Uzor on 23/08/2023.
//

import Foundation

class MembersAPIClient {
    func fetchMembersList(completion: @escaping (Result<MembersListResponse, Error>) -> Void) {
        let urlString = "\(BASE_URL)users/"
        
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
                    do {
                        let decoder = JSONDecoder()
                        //decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case to camelCase conversion if needed
                        let membersListResponse = try decoder.decode(MembersListResponse.self, from: data)
                        completion(.success(membersListResponse))
                        print("response: \(membersListResponse)")

                    } catch {
                        completion(.failure(error))
                        print(error)
                    }
                } else {
                    
                    completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
                }
            }.resume()
        
    }
    
    
    enum MemberError: Error {
            case networkError(Error)
            case noData
            case decodingError(Error)
        }
    
    static func sendFriendRequest(userId: String, completion: @escaping (Result<SendFriendRequestResponse, MemberError>) -> Void)  {//}-> AnyPublisher<LoginResponse, Error> {
        let url = URL(string: "\(BASE_URL)friendrequests")! // Replace with your API URL

        print("making api call...")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Add the bearer token
        let body: [String: AnyHashable] = [
            "userId": userId
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            if let error = error {
                completion(.failure(error as! MembersAPIClient.MemberError))
                           return
                       }
                       
                       guard let data = data else {
                           completion(.failure(.noData))
                           return
                       }
                       
                       do {
                           let response = try decoder.decode(SendFriendRequestResponse.self, from: data)
                           completion(.success(response))
                           print("response: \(response)")
                       } catch {
                           completion(.failure(error as! MembersAPIClient.MemberError))
                       }
            
        }
        task.resume()
    }
    
    
    func fetchFriendsList(completion: @escaping (Result<GetFriendsResponse, Error>) -> Void) {
        let urlString = "\(BASE_URL)friends"
        
        print("making api call...")
        
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
                    print("here")
                    do {
                        let decoder = JSONDecoder()
                        //decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case to camelCase conversion if needed
                        let friendsListResponse = try decoder.decode(GetFriendsResponse.self, from: data)
                        completion(.success(friendsListResponse))
                        print("response: \(friendsListResponse)")

                    } catch {
                        completion(.failure(error))
                        print(error)
                    }
                } else {
                    
                    completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
                }
            }.resume()
        
    }
        
}
