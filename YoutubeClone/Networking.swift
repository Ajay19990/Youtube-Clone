//
//  Networking.swift
//  YoutubeClone
//
//  Created by Ajay Choudhary on 09/07/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import Foundation

class YoutubeClient {
    class func getVideos(completion: @escaping (Result<[Video], ErrorMessage>) -> Void) {
        
        guard let url = URL(string: Constants.API_URL) else {
            completion(.failure(.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Response.self, from: data)
                completion(.success(response.items))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
}
