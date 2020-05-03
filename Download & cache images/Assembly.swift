//
//  Assembly.swift
//  Download & cache images
//
//  Created by Виктор on 01.05.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import UIKit

final class Assembly {
    static func assemble() -> UIViewController {
        let vc = MainViewController()
        vc.viewModel = ViewModel()
        return vc
    }
}
