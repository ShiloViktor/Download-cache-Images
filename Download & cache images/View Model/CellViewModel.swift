//
//  CellViewModel.swift
//  Download & cache images
//
//  Created by Виктор on 01.05.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import  UIKit

final class CellViewModel: CellViewModelType {
    
    var ImageUrl: String {
        return image.url
    }
    
    private var image: Image
    
    init(image: Image) {
        self.image = image
    }
}
