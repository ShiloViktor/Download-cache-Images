//
//  Network Service.swift
//  Download & cache images
//
//  Created by Виктор on 29.04.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import UIKit

class WebImageView: UIImageView {
    
    func set(imageUrl: String, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrl) else {
            self.image = nil
            return
        }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            print("From Cachex")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, let response = response else {
                return
            }
            self?.handleLoadedImage(data: data, response: response)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                print("From internet")
                completion(image)
            }
        }
        task.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    }
    
    func removeCache() {
        URLCache.shared.removeAllCachedResponses()
    }
}
