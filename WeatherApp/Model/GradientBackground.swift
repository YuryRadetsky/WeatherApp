//
//  Gradient.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 06.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
//swiftlint:disable all

class GradientBackground {

    // Gradient background Updates
    func createGradientLayer(weatherId: Int, controller: UIViewController) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = controller.view.bounds
        controller.view.layer.insertSublayer(gradientLayer, at: 0)

        switch weatherId {
        case 200...232:
            print("Thunderstorm")
            gradientLayer.colors = [UIColor(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor,
                                    UIColor(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1).cgColor]
        case 300...321:
            print("Drizzle")
            gradientLayer.colors = [UIColor(red: 0.6207757569, green: 0.9686274529, blue: 0.9110963382, alpha: 1).cgColor,
                                    UIColor(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor]
        case 500:
            print("Rain")
            gradientLayer.colors = [UIColor(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor,
                                    UIColor(red: 0.2854045624, green: 0.4267300284, blue: 0.6992385787, alpha: 1).cgColor]
        case 501:
            print("Rain")
            gradientLayer.colors = [UIColor(red: 0.3437546921, green: 0.6157113381, blue: 0.7179171954, alpha: 1).cgColor,
                                    UIColor(red: 0.4118283819, green: 0.5814552154, blue: 0.6975531409, alpha: 1).cgColor]
        case 502...511:
            print("Rain")
            gradientLayer.colors = [UIColor(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor,
                                    UIColor(red: 0.1596036421, green: 0, blue: 0.5802268401, alpha: 1).cgColor]
        case 520...521:
            print("Rain")
            gradientLayer.colors = [UIColor(red: 0.7433765433, green: 0.9529411793, blue: 0.8886958889, alpha: 1).cgColor,
                                    UIColor(red: 0.4561494407, green: 0.6342332627, blue: 0.7568627596, alpha: 1).cgColor]
        case 522...531:
            print("Rain")
            gradientLayer.colors = [UIColor(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor,
                                    UIColor(red: 0.1596036421, green: 0, blue: 0.5802268401, alpha: 1).cgColor]
        case 600...622:
            print("Snow")
            gradientLayer.colors = [UIColor(red: 0.8229460361, green: 0.8420813229, blue: 0.9764705896, alpha: 1).cgColor,
                                    UIColor(red: 0.6424972056, green: 0.9015246284, blue: 0.9529411793, alpha: 1).cgColor]
        case 701...781:
            print("Atmosphere")
            gradientLayer.colors = [UIColor(red: 0.6324083141, green: 0.8039215803, blue: 0.7850640474, alpha: 1).cgColor,
                                    UIColor(red: 0.4545597353, green: 0.393878495, blue: 0.5369011739, alpha: 1).cgColor]
        case 800:
            print("Clear")
            gradientLayer.colors = [UIColor(red: 0.6544341662, green: 0.9271220419, blue: 0.9764705896, alpha: 1).cgColor,
                                    UIColor(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor]
        case 801...804:
            print("Clouds")
            gradientLayer.colors = [UIColor(red: 0.5088317674, green: 0.5486197199, blue: 0.7256778298, alpha: 1).cgColor,
                                    UIColor(red: 0.3843137255, green: 0.4117647059, blue: 0.5450980392, alpha: 1).cgColor]
        default:
            print("error")
        }

    }

}
