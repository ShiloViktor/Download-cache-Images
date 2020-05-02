//
//  NetworkManager.swift
//  Download & cache images
//
//  Created by Виктор on 02.05.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    func downloadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func downloadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else { return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            let image = UIImage(data: cachedResponse.data)
            completion(image)
            print("From Cachex")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, let response = response else {
                return
            }
            CacheManager.handleLoadedImage(data: data, response: response)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                print("From internet")
                completion(image)
            }
        }
        task.resume()
    }
}
