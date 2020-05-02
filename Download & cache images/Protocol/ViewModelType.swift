//
//  ViewModelType.swift
//  Download & cache images
//
//  Created by Виктор on 01.05.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation

protocol ViewModelType {
    func numbersOfRows() -> Int 
    func cellViewModel(forIndexPAth indexPath: IndexPath) -> CellViewModelType?
    var images: [Image] { get set }
    var cellDataSource: [Image] { get set }
}
