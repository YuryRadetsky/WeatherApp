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
    func setupBackgroundColor(weatherId: Int, viewController: UIViewController) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewController.view.bounds
        viewController.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let id = weatherId
        switch id {
        case 200...232:
            gradientLayer.colors = [UIColor(ciColor: .blue).cgColor, UIColor(ciColor: .black).cgColor]
            print("Thunderstorm")
        case 300...321:
            gradientLayer.colors = [UIColor(ciColor: .gray).cgColor, UIColor(ciColor: .white).cgColor]
            print("Drizzle")
        case 500...531:
            gradientLayer.colors = [UIColor(ciColor: .gray).cgColor, UIColor(ciColor: .cyan).cgColor]
            print("Rain")
        case 600...622:
            gradientLayer.colors = [UIColor(ciColor: .white).cgColor, UIColor(ciColor: .gray).cgColor]
            print("Snow")
        case 701...781:
            gradientLayer.colors = [UIColor(ciColor: .cyan).cgColor, UIColor(ciColor: .gray).cgColor]
            print("Atmosphere")
        case 800:
            gradientLayer.colors = [UIColor(ciColor: .red).cgColor, UIColor(ciColor: .yellow).cgColor]
            print("Clear")
        case 801...804:
            gradientLayer.colors = [UIColor(ciColor: .black).cgColor, UIColor(ciColor: .cyan).cgColor]

            print("Clouds")
        default:
            gradientLayer.colors = [UIColor(ciColor: .black).cgColor, UIColor(ciColor: .red).cgColor]
            print("N/A")
        }
        
    }
        //Gradient background
    //    func setupGradient() {
    //        let gradientLayer = CAGradientLayer()
    //        gradientLayer.frame = self.view.bounds
    //        gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
    //                                UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
    //        self.view.layer.insertSublayer(gradientLayer, at: 0)
    //    }
    
}
