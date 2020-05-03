//
//  Cache Manager.swift
//  Download & cache images
//
//  Created by Виктор on 01.05.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import UIKit

final class CacheManager {
    
    static var shared = CacheManager()
    
    func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    }
    
    func removeCache() {
        URLCache.shared.removeAllCachedResponses()
    }
    
    func checkCache(forUrl url: URL) -> UIImage? {
        guard let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) else { return nil }
        guard let image = UIImage(data: cachedResponse.data) else { return nil }
        print("From Cachex")
        return image
    }
}
