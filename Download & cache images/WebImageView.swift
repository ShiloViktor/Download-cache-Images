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
    func set(imageUrl: [String?], indexPath: IndexPath) {
        guard let imageUrl = imageUrl[indexPath.row], let url = URL(string: imageUrl) else {
            self.image = nil
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
