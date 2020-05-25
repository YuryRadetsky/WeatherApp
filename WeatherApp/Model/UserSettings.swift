//
//  FavoriteCity.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import Foundation

class UserSettings {
        static let shared = UserSettings()
    
    private init(){
        let citiesFromDefaults = defaults.array(forKey: "saveCity")
        if citiesFromDefaults != nil {
            favoriteCity = citiesFromDefaults as! [String]
        } else {
            favoriteCity = []
        }
    }
    
    private let defaults = UserDefaults.standard
    
    var favoriteCity: [String] = []
    
    
    func saveToDefaults() {
        defaults.set(favoriteCity, forKey: "saveCity")

    }
}
