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
    
    var favoriteCity: [String] {
        set {
            UserDefaults.standard.set(newValue, forKey: "saveCity")
            UserDefaults.standard.synchronize()
        }
        get {
            let citiesFromDefaults = UserDefaults.standard.array(forKey: "saveCity") as? [String]
            guard citiesFromDefaults != nil else {return []}
            return citiesFromDefaults ?? []
        }
    }
    
    private init() {}
    
    func saveToDefaults() {
        UserDefaults.standard.set(favoriteCity, forKey: "saveCity")
    }
}
