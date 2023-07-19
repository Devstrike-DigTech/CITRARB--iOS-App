//
//  TVAPI.swift
//  CITRARB
//
//  Created by Richard Uzor on 19/07/2023.
//

import Foundation

import SwiftUI

class APIClient {
    func fetchTVList(completion: @escaping (Result<TVListResponse, Error>) -> Void) {
        let urlString = "\(BASE_URL)tv?ksalf"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let tvListResponse = try decoder.decode(TVListResponse.self, from: data)
                        completion(.success(tvListResponse))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
                }
            }.resume()
        } else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
        }
    }
}

