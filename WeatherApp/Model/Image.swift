//
//  Image.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 06.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
//swiftlint:disable identifier_name

class Image {

    func weatherCondition(iconId: String, imageView: UIImageView) {
        switch iconId {
        case "01d":
            imageView.image = UIImage(systemName: "circle.fill")
        case "02d":
            imageView.image = UIImage(systemName: "cloud.sun.fill")
        case "03d":
            imageView.image = UIImage(systemName: "cloud.fill")
        case "04d":
            imageView.image = UIImage(systemName: "smoke.fill")
        case "09d":
            imageView.image = UIImage(systemName: "cloud.drizzle.fill")
        case "10d":
            imageView.image = UIImage(systemName: "cloud.sun.rain.fill")
        case "11d":
            imageView.image = UIImage(systemName: "cloud.bolt.fill")
        case "13d":
            imageView.image = UIImage(systemName: "snow")
        case "50d":
            imageView.image = UIImage(systemName: "cloud.fog.fill")
        case "01n":
            imageView.image = UIImage(systemName: "moon.stars.fill")
        case "02n":
            imageView.image = UIImage(systemName: "cloud.moon.fill")
        case "03n":
            imageView.image = UIImage(systemName: "cloud.fill")
        case "04n":
            imageView.image = UIImage(systemName: "smoke.fill")
        case "09n":
            imageView.image = UIImage(systemName: "cloud.drizzle.fill")
        case "10n":
            imageView.image = UIImage(systemName: "cloud.moon.rain.fill")
        case "11n":
            imageView.image = UIImage(systemName: "cloud.bolt.fill")
        case "13n":
            imageView.image = UIImage(systemName: "snow")
        case "50n":
            imageView.image = UIImage(systemName: "cloud.fog.fill")
        default:
            print("error")
            imageView.image = UIImage(systemName: "aqi.high")
        }
    }

}
