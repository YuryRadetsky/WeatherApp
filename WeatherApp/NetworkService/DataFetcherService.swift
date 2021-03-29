//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 25.04.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import Foundation
import CoreLocation
//swiftlint:disable all

class DataFetcherService {
    
    // MARK: - IBOutlets
    
    let locationManager = CLLocationManager()
    var networkDataFetcher: DataFetcher
    
    // MARK: - Initializers

    init (networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    // MARK: - Public Methods
    
    func fetchWeatherData (forCity city: String, completion: @escaping (WeatherModel?) -> Void) {
        let city = city.split(separator: " ").joined(separator: "%20")
        let urlString = APIManager.shared.getCityURL(forCity: city)
        networkDataFetcher.fetchGenericData(urlString: urlString, completion: completion)
    }
    
    func fetchWeatherData (latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (WeatherModel?) -> Void) {
        let urlString = APIManager.shared.getLocationURL(latitude: latitude, longitude: longitude)
        networkDataFetcher.fetchGenericData(urlString: urlString, completion: completion)
    }
    
}
