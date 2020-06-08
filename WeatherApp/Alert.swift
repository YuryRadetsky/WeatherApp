//
//  File.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 27.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    func showAlert (title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
