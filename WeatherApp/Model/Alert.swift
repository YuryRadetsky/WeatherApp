//
//  File.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 27.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import Foundation
import UIKit


struct Alert {
    static func showAlert(onVC vc: UIViewController, withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
