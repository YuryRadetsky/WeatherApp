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
    func setupBackgroundColor(temperature: Int, viewController: UIViewController) {
        let temp = temperature
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewController.view.bounds
        viewController.view.layer.insertSublayer(gradientLayer, at: 0)
        
        // В зависимости от полученной температуры меняется backgroundColor
        switch temp {
        case ...0:
            gradientLayer.colors = [UIColor(red: 135/255, green: 80/255, blue: 200/255, alpha: 1).cgColor,
                                    UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
            print("...0")
        case 0...10:
            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
                                    UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
            print("0...10")
        case 10...20:
            gradientLayer.colors = [UIColor(red: 150/255, green: 90/255, blue: 210/255, alpha: 1).cgColor,
                                    UIColor(red: 90/255, green: 80/255, blue: 250/255, alpha: 1).cgColor]
            print("10...20")
        case 20...30:
            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
                                    UIColor(red: 80/255, green: 70/255, blue: 240/255, alpha: 1).cgColor]
            print("20...30")
        case 30...:
            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
                                    UIColor(red: 70/255, green: 60/255, blue: 230/255, alpha: 1).cgColor]
            print("30...")
        default:
            print("...")
        }
    }
    
    //    // Gradient background Updates
    //    func setupBackgroundColor(temperature: Int) {
    //        let temp = temperature
    //
    //        let gradientLayer = CAGradientLayer()
    //        gradientLayer.frame = self.view.bounds
    //        self.view.layer.insertSublayer(gradientLayer, at: 0)
    //
    //        // В зависимости от полученной температуры меняется backgroundColor
    //        switch temp {
    //        case ...0:
    //            gradientLayer.colors = [UIColor(red: 135/255, green: 80/255, blue: 200/255, alpha: 1).cgColor,
    //                                    UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
    //            print("...0")
    //        case 0...10:
    //            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
    //                                    UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
    //            print("0...10")
    //        case 10...20:
    //            gradientLayer.colors = [UIColor(red: 150/255, green: 90/255, blue: 210/255, alpha: 1).cgColor,
    //                                    UIColor(red: 90/255, green: 80/255, blue: 250/255, alpha: 1).cgColor]
    //            print("10...20")
    //        case 20...30:
    //            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
    //                                    UIColor(red: 80/255, green: 70/255, blue: 240/255, alpha: 1).cgColor]
    //            print("20...30")
    //        case 30...:
    //            gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
    //                                    UIColor(red: 70/255, green: 60/255, blue: 230/255, alpha: 1).cgColor]
    //            print("30...")
    //        default:
    //            print("...")
    //        }
    //    }
    
}
