//
//  ViewModel.swift
//  Download & cache images
//
//  Created by Виктор on 30.04.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import UIKit

final class ViewModel: ViewModelType {
    
    var cellDataSource: [Image] = []
    
    var images: [Image] = [
        Image(url: "https://s1.1zoom.me/b5050/995/Ocean_Island_Mountains_Sky_Mauritius_From_above_582975_800x600.jpg", image: nil),
        Image(url:  "https://s1.1zoom.me/b5050/367/Mountains_Italy_Lake_Boats_Marinas_Lago_di_Braies_581849_800x600.jpg", image: nil),
        Image(url: "https://s1.1zoom.me/b5050/431/Russia_Crimea_Coast_Sea_Crag_Trees_581991_800x600.jpg", image: nil),
        Image(url: "https://s1.1zoom.me/b5050/680/Winter_Sky_Mountains_Snow_Night_Moon_Clouds_581802_800x600.jpg", image: nil),
        Image(url: "https://s1.1zoom.me/b5050/321/Pond_Sky_Pagodas_Temples_Japan_Kansai_Byodo-in_Uji_581333_800x600.jpg", image: nil),
    Image(url: "https://s1.1zoom.me/b5255/337/Roads_Sky_England_Scenery_Mam_Tor_Peak_District_580899_800x600.jpg", image: nil)]
    
    func numbersOfRows() -> Int {
        return cellDataSource.count
     }
    
    func cellViewModel(forIndexPAth indexPath: IndexPath) -> CellViewModelType? {
        let image = cellDataSource[indexPath.row]
        return CellViewModel(image: image)
     }
}
