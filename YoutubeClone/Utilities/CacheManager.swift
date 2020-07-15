//
//  CacheManager.swift
//  YoutubeClone
//
//  Created by Ajay Choudhary on 15/07/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var cache = [String: Data]()
    
    static func setVideCache(_ url: String, _ data: Data) {
        cache[url] = data
    }
    
    static func getVideoCache(_ url:String) -> Data? {
        return cache[url]
    }
}
