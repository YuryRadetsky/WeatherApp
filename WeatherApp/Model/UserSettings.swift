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
    private init() {
        let citiesFromDefaults = defaults.array(forKey: "saveCity")
        guard citiesFromDefaults != nil else {return}
        favoriteCity = citiesFromDefaults as? [String] ?? []
    }
    
    private let defaults = UserDefaults.standard
    
    var favoriteCity: [String] = []
    let citiesFromDefaults = UserDefaults.standard.array(forKey: "saveCity")
    
    func saveToDefaults() {
        defaults.set(favoriteCity, forKey: "saveCity")

    }
}
