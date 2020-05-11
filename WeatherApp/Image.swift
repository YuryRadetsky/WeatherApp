//
//  Image.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 06.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit

class Image {

    func weatherCondition(weatherId: Int, imageView: UIImageView) {
        
        let id = weatherId
        switch id {
        case 200...232:
            imageView.image = UIImage(named: "icon_rain")
            print("Thunderstorm")
        case 300...321:
            imageView.image = UIImage(named: "icon_rain")
            print("Drizzle")
        case 500...531:
            imageView.image = UIImage(named: "icon_rain")
            print("Rain")
        case 600...622:
            imageView.image = UIImage(named: "icon_snow")
            print("Snow")
        case 701...781:
            imageView.image = UIImage(named: "icon_fog")
            print("Atmosphere")
        case 800:
            imageView.image = UIImage(named: "icon_sun")
            print("Clear")
        case 801...804:
            imageView.image = UIImage(named: "icon_fog")
            print("Clouds")
        default:
            imageView.image = UIImage(named: "icon_na")
            print("N/A")
        }
    }
    
}
