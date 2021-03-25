//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 25.04.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
//swiftlint:disable vertical_whitespace
//swiftlint:disable trailing_whitespace

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var searchBarr: UISearchBar!
    
    
    var favoriteCity = UserSettings.shared.favoriteCity
    let networkService = DataFetcherService()
    let gradient = GradientBackground()
    let image = Image()
    var delay: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultValues()
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        guard let city = searchBarr.searchTextField.text else {return}
        if city.isEmpty {
            Alert.showAlert(onVC: self, withTitle: "Alert", message: "Enter the city name")
        } else {
            UserSettings.shared.favoriteCity.append("\(city)")
            UserSettings.shared.saveToDefaults()
            searchBarr.text = nil
            print(UserSettings.shared.favoriteCity)
        }
    }
    
    func setupDefaultValues() {
        cityNameLabel.text = "City"
        feelLikeLabel.text = "feels like -- ℃"
        conditionImageView.image = UIImage(named: "icon_na")
        currentTemperatureLabel.text = "--"
        minTemperatureLabel.text = "-- ℃"
        maxTemperatureLabel.text = "-- ℃"
        descriptionWeatherLabel.text = "description"
        view.backgroundColor = .systemGray2
    }
    
    // Hide the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.searchBarr.endEditing(true)
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        delay?.invalidate()
        delay = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            self.networkService.fetchWeatherData(forCity: searchText) { [weak self] (weatherStruct) in
                guard let weatherStruct = weatherStruct else { return }
                // UI Updates
                self?.cityNameLabel.text = weatherStruct.name
                self?.feelLikeLabel.text = "feels like " + String(Int(weatherStruct.main.feelsLike)) + " ℃"
                self?.currentTemperatureLabel.text = String(Int(weatherStruct.main.temp))
                for weather in weatherStruct.weather {
                    self?.descriptionWeatherLabel.text = weather.weatherDescription
                    // conditionImage
                    self?.image.weatherCondition(iconId: weather.icon, imageView: self!.conditionImageView)
                    // Gradient background Updates
                    self?.gradient.createGradientLayer(weatherId: weather.id, controller: self!)
                }
                self?.minTemperatureLabel.text = String(Int(weatherStruct.main.tempMin))
                self?.maxTemperatureLabel.text = String(Int(weatherStruct.main.tempMax))
                self?.humidityLabel.text = String(weatherStruct.main.humidity) + " %"
                
            }
        })
        
    }
}
