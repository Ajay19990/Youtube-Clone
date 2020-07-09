//
//  Networking.swift
//  YoutubeClone
//
//  Created by Ajay Choudhary on 09/07/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import Foundation

class YoutubeClient {
    class func getVideos() {
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        
    }
}
