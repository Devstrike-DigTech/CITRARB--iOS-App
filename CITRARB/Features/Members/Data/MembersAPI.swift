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
