//
//  ProfileAPI.swift
//  CITRARB
//
//  Created by Richard Uzor on 03/08/2023.
//

import Foundation
import Combine

class AuthService {
    
    enum AuthError: Error {
            case networkError(Error)
            case noData
            case decodingError(Error)
        }
    
    static func login(email: String, password: String, completion: @escaping (Result<LoginResponse, AuthError>) -> Void)  {//}-> AnyPublisher<LoginResponse, Error> {
        let url = URL(string: "\(BASE_URL)users/login")! // Replace with your API URL

        print("making api call...")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "email": email,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            if let error = error {
                print(error)
                return
            }
                       
                       guard let data = data else {
                           completion(.failure(.noData))
                           return
                       }
                       
                       do {
                           let response = try decoder.decode(LoginResponse.self, from: data)
                           completion(.success(response))
                           UserDefaults.standard.set(response.token, forKey: AUTH_TOKEN_KEY)
                           UserDefaults.standard.set(response.user._id, forKey: USER_ID)

                       } catch {
                           print(error)
                       }
            
        }
        task.resume()
    }
        
    static func register(username: String, email: String, password: String, confirmPassword: String, completion: @escaping (Result<SignupResponse, AuthError>) -> Void)  {
        let url = URL(string: "\(BASE_URL)users/signup")! // Replace with your API URL

        print("making api call...")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "username": username,
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            if let error = error {
                completion(.failure(error as! AuthService.AuthError))
                           return
                       }
                       
                       guard let data = data else {
                           completion(.failure(.noData))
                           return
                       }
                       
                       do {
                           let response = try decoder.decode(SignupResponse.self, from: data)
                           completion(.success(response))
                           UserDefaults.standard.set(response.token, forKey: AUTH_TOKEN_KEY)
                           UserDefaults.standard.set(response.user._id, forKey: USER_ID)
                       } catch {
                           completion(.failure(error as! AuthService.AuthError))
                       }
            
        }
        task.resume()
    }
    
    func fetchUserProfile(completion: @escaping (Result<GetMeResponse, Error>) -> Void) {
        let urlString = "\(BASE_URL)users/me"
       
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
                    print("User Profile Response data: \(responseString)")
                } else {
                    print("Response data cannot be converted to a string.")
                }
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case to camelCase conversion if needed
                    let userResponse = try decoder.decode(GetMeResponse.self, from: data)
                    completion(.success(userResponse))
                    print("response: \(userResponse)")
                    
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else {
                
                completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
            }
        }.resume()
        
    }
    
    func deleteMe(completion: @escaping (Result<Void, Error>) -> Void) {
        
            let urlString = "\(BASE_URL)users/"
       
        
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
                    print("Delete Me Response data: \(responseString)")
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
    
    
    
}

