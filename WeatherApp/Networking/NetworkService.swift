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
//swiftlint:disable unused_closure_parameter

class NetworkService {
    let locationManager = CLLocationManager()
    
    
    func request (city: String, completion: @escaping (Result<WeatherStruct, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        print("URL string: city - ", urlString)
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do {
                let weatherData = try JSONDecoder().decode(WeatherStruct.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weatherData))
                }
                
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
            }
        } .resume()
    }
    
    func request (latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherStruct, Error>) -> Void) {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        print("URL string: location - ", urlString)
        
        guard let url = URL(string: urlString) else {return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherStruct.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weatherData))
                }
            } catch let jsonError {
                print("Failed to decode JSON ", jsonError)
            }
        } .resume()
    }
}
