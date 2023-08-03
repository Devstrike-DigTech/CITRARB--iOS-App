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
                completion(.failure(error as! AuthService.AuthError))
                           return
                       }
                       
                       guard let data = data else {
                           completion(.failure(.noData))
                           return
                       }
                       
                       do {
                           let response = try decoder.decode(LoginResponse.self, from: data)
                           completion(.success(response))
                           UserDefaults.standard.set(response.token, forKey: "AuthToken")
                       } catch {
                           completion(.failure(error as! AuthService.AuthError))
                       }
            
        }
        task.resume()
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .map(\.data)
//            .decode(type: LoginResponse.self, decoder: decoder)
//            .eraseToAnyPublisher()
    }
}

