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

final class NetworkManager: NetworkManagerProtocol {
    
    static var shared = NetworkManager()
    
    func downloadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else { return }
        
        if let image = CacheManager.shared.checkCache(forUrl: url) {
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {
                return
            }
            CacheManager.shared.handleLoadedImage(data: data, response: response)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                print("From internet")
                completion(image)
            }
        }
        task.resume()
    }
}
