//
//  Image.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 06.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit

class Image {

    func weatherCondition(weatherId: Int, conditionImageView: UIImageView) {
        let id = weatherId
        switch id {
        case 200...232:
            conditionImageView.image = UIImage(named: "icon_rain")
            print("Thunderstorm")
        case 300...321:
            conditionImageView.image = UIImage(named: "icon_rain")
            print("Drizzle")
        case 500...531:
            conditionImageView.image = UIImage(named: "icon_rain")
            print("Rain")
        case 600...622:
            conditionImageView.image = UIImage(named: "icon_snow")
            print("Snow")
        case 701...781:
            conditionImageView.image = UIImage(named: "icon_fog")
            print("Atmosphere")
        case 800:
            conditionImageView.image = UIImage(named: "icon_sun")
            print("Clear")
        case 801...804:
            conditionImageView.image = UIImage(named: "icon_fog")
            print("Clouds")
        default:
            conditionImageView.image = UIImage(named: "icon_na")
            print("N/A")
        }
    }
    
//    /    func weatherCondition(weatherId: Int) {
    //        let id = weatherId
    //        switch id {
    //        case 200...232:
    //            conditionImageView.image = UIImage(named: "icon_rain")
    //            print("Thunderstorm")
    //        case 300...321:
    //            conditionImageView.image = UIImage(named: "icon_rain")
    //            print("Drizzle")
    //        case 500...531:
    //            conditionImageView.image = UIImage(named: "icon_rain")
    //            print("Rain")
    //        case 600...622:
    //            conditionImageView.image = UIImage(named: "icon_snow")
    //            print("Snow")
    //        case 701...781:
    //            conditionImageView.image = UIImage(named: "icon_fog")
    //            print("Atmosphere")
    //        case 800:
    //            conditionImageView.image = UIImage(named: "icon_sun")
    //            print("Clear")
    //        case 801...804:
    //            conditionImageView.image = UIImage(named: "icon_fog")
    //            print("Clouds")
    //        default:
    //            conditionImageView.image = UIImage(named: "icon_na")
    //            print("")
    //        }
    //    }

}
