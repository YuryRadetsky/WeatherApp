//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 25.04.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import Foundation
import CoreLocation
//swiftlint:disable trailing_whitespace
//swiftlint:disable line_length

class DataFetcherService {
    let locationManager = CLLocationManager()
    var networkDataFetcher: DataFetcher
    
    init (networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchWeather (forCity city: String, completion: @escaping (WeatherStruct?) -> Void) {
        let city = city.split(separator: " ").joined(separator: "%20")
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        networkDataFetcher.fetchData(urlString: urlString, completion: completion)
    }
    
    func fetchWeather (latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (WeatherStruct?) -> Void) {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        networkDataFetcher.fetchData(urlString: urlString, completion: completion)
    }
}
