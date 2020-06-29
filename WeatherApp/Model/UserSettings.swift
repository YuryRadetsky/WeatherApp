//
//  FavoriteCity.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import Foundation
//swiftlint:disable trailing_whitespace

class UserSettings {
    
    static let shared = UserSettings()
    
    var favoriteCity: [String] = []
    let citiesFromDefaults = UserDefaults.standard.array(forKey: "saveCity")
    
    
    private let defaults = UserDefaults.standard
    
    
    private init() {
        let citiesFromDefaults = defaults.array(forKey: "saveCity")
        guard citiesFromDefaults != nil else {return}
        favoriteCity = citiesFromDefaults as? [String] ?? []
    }
    
    
    func saveToDefaults() {
        defaults.set(favoriteCity, forKey: "saveCity")
    }
}
