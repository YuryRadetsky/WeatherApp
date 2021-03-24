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
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var searchBarr: UISearchBar!
    
    
    var favoriteCity = UserSettings.shared.favoriteCity
    let networkService = DataFetcherService()
    var weatherStruct: WeatherStruct?
    let gradient = Gradient()
    let image = Image()
    var delay: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = "City"
        feelLikeLabel.text = "feels like -- ℃"
        conditionImageView.image = UIImage(named: "icon_na")
        temperatureLabel.text = "--"
        conditionLabel.text = "CONDITION"
        min.text = "-- ℃"
        max.text = "-- ℃"
        pressure.text = "-- hPa"
        humidity.text = "-- %"
        descriptionWeather.text = "description"
        view.backgroundColor = .systemGray2
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        guard let city = searchBarr.searchTextField.text else {return}
        if city.isEmpty {
            Alert().showAlert(title: "Alert", message: "Enter the city name", viewController: self)
        } else {
            UserSettings.shared.favoriteCity.append("\(city)")
            UserSettings.shared.saveToDefaults()
            searchBarr.text = nil
            print(UserSettings.shared.favoriteCity)
        }
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
            self.networkService.fetchWeather(forCity: searchText) { [weak self] (weatherStruct) in
                guard let weatherStruct = weatherStruct else { return }
                print(weatherStruct.base.count, weatherStruct)
                self?.weatherStruct = weatherStruct
                // UI Updates
                self?.cityNameLabel.text = weatherStruct.name
                self?.feelLikeLabel.text = "feels like " + String(Int(weatherStruct.main.feelsLike)) + " ℃"
                self?.temperatureLabel.text = String(Int(weatherStruct.main.temp))
                for weather in weatherStruct.weather {
                    self?.conditionLabel.text = weather.main.localizedUppercase
                    self?.descriptionWeather.text = weather.weatherDescription
                    // conditionImage
                    self?.image.weatherCondition(iconId: weather.icon, imageView: self!.conditionImageView)
                    // Gradient background Updates
                    self?.gradient.createGradientLayer(weatherId: weather.id, viewController: self!)
                }
                self?.min.text = String(Int(weatherStruct.main.tempMin)) + " ℃"
                self?.max.text = String(Int(weatherStruct.main.tempMax)) + " ℃"
                self?.pressure.text = String(weatherStruct.main.pressure) + " hPa"
                self?.humidity.text = String(weatherStruct.main.humidity) + " %"
                
            }
        })
        
    }
}
