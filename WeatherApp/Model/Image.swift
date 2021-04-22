//
//  Image.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 06.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
//swiftlint:disable all

class Image {

    func weatherCondition(iconId: String, imageView: UIImageView) {
        switch iconId {
        case "01d":
            imageView.image = UIImage(systemName: "circle")
        case "02d":
            imageView.image = UIImage(systemName: "cloud.sun")
        case "03d":
            imageView.image = UIImage(systemName: "cloud")
        case "04d":
            imageView.image = UIImage(systemName: "smoke")
        case "09d":
            imageView.image = UIImage(systemName: "cloud.drizzle")
        case "10d":
            imageView.image = UIImage(systemName: "cloud.sun.rain")
        case "11d":
            imageView.image = UIImage(systemName: "cloud.bolt")
        case "13d":
            imageView.image = UIImage(systemName: "snow")
        case "50d":
            imageView.image = UIImage(systemName: "cloud.fog")
        case "01n":
            imageView.image = UIImage(systemName: "moon.stars")
        case "02n":
            imageView.image = UIImage(systemName: "cloud.moon")
        case "03n":
            imageView.image = UIImage(systemName: "cloud")
        case "04n":
            imageView.image = UIImage(systemName: "smoke")
        case "09n":
            imageView.image = UIImage(systemName: "cloud.drizzle")
        case "10n":
            imageView.image = UIImage(systemName: "cloud.moon.rain")
        case "11n":
            imageView.image = UIImage(systemName: "cloud.bolt")
        case "13n":
            imageView.image = UIImage(systemName: "snow")
        case "50n":
            imageView.image = UIImage(systemName: "cloud.fog")
        default:
            print("error")
            imageView.image = UIImage(systemName: "aqi.high")
        }
    }

}
