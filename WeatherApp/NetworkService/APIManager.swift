//
//  URLComponentsManager.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.03.2021.
//  Copyright © 2021 YuryRadetsky. All rights reserved.
//

import Foundation
import CoreLocation
//swiftlint:disable all

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func getCityURL(forCity city: String) -> String {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/weather"
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key)
        ]
        guard let componentsSrting = components.string else { return "" }
        return componentsSrting
    }
    
    func getLocationURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/weather"
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key)
        ]
        guard let componentsSrting = components.string else { return "" }
        return componentsSrting
    }
}
