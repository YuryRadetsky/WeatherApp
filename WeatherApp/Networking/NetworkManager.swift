//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 30.04.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
import CoreLocation

struct NetworkManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=da2798e7e8c96956caff9ac80cce3ebe&units=metric"
    var weatherStruct: WeatherStruct? = nil
    let networkService = NetworkService()
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
          let apiUrl = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
                 print(apiUrl)
          
          
      }
    
}
