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
    
    func fetchWeatherData (forCity city: String, completion: @escaping (WeatherStruct?) -> Void) {
        let city = city.split(separator: " ").joined(separator: "%20")
        let urlString = APIManager.shared.getCityURL(forCity: city)
        networkDataFetcher.fetchData(urlString: urlString, completion: completion)
    }
    
    func fetchWeatherData (latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (WeatherStruct?) -> Void) {
        let urlString = APIManager.shared.getLocationURL(latitude: latitude, longitude: longitude)
        networkDataFetcher.fetchData(urlString: urlString, completion: completion)
    }
    
}
