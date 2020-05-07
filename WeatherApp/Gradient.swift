//
//  Gradient.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 06.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit

class Gradient {
    
    // Gradient background Updates
    func setupBackgroundColor(weatherId: Int) {
        let viewController = UIViewController()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewController.view.bounds
        viewController.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let id = weatherId
        switch id {
        case 200...232:
            gradientLayer.colors = [UIColor(red: 135/255, green: 80/255, blue: 200/255, alpha: 1).cgColor,
                                    UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
            print("Thunderstorm")
        case 300...321:
            gradientLayer.colors = [UIColor(red: 135/255, green: 80/255, blue: 200/255, alpha: 1).cgColor,
                                    UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
            print("Drizzle")
        case 500...531:
            gradientLayer.colors = [UIColor(red: 135/255, green: 80/255, blue: 200/255, alpha: 1).cgColor,
                                    UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
            print("Rain")
        case 600...622:
            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
                                    UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
            print("Snow")
        case 701...781:
            gradientLayer.colors = [UIColor(red: 150/255, green: 90/255, blue: 210/255, alpha: 1).cgColor,
                                    UIColor(red: 90/255, green: 80/255, blue: 250/255, alpha: 1).cgColor]
            print("Atmosphere")
        case 800:
            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
                                    UIColor(red: 80/255, green: 70/255, blue: 240/255, alpha: 1).cgColor]
            print("Clear")
        case 801...804:
            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
                                    UIColor(red: 70/255, green: 60/255, blue: 230/255, alpha: 1).cgColor]
            print("Clouds")
        default:
            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
                                    UIColor(red: 70/255, green: 60/255, blue: 230/255, alpha: 1).cgColor]
            //            viewController.view.backgroundColor = .red
            print("N/A")
        }
        
    }
    
}
