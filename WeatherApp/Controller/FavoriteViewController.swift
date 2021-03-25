//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
//swiftlint:disable trailing_whitespace
//swiftlint:disable vertical_whitespace
class FavoriteViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    let networkService = DataFetcherService()
    let gradient = GradientBackground()
    let image = Image()
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultValues()
        setupCustomNavigationBar()
        fetchFaviriteCity(city: city)
    }
    
    
    @IBAction func refreshRapped(_ sender: UIBarButtonItem) {
        fetchFaviriteCity(city: city)
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
    
    func setupCustomNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
    
    func fetchFaviriteCity (city: String ) {
        networkService.fetchWeatherData(forCity: city) { [weak self] (weaatherStruct) in
            guard let weaatherStruct = weaatherStruct else { return }
            // UI Updates
            self?.cityNameLabel.text = weaatherStruct.name
            self?.feelLikeLabel.text = "feels like " + String(Int(weaatherStruct.main.feelsLike)) + " ℃"
            self?.currentTemperatureLabel.text = "\(Int(weaatherStruct.main.temp))"
            
            for weather in weaatherStruct.weather {
                self?.descriptionWeatherLabel.text = weather.weatherDescription
                // Image Updates
                self?.image.weatherCondition(iconId: weather.icon, imageView: self!.conditionImageView)
                // Gradient background Updates //
                self?.gradient.createGradientLayer(weatherId: weather.id, controller: self!)
            }
            self?.minTemperatureLabel.text = String(Int(weaatherStruct.main.tempMin))
            self?.maxTemperatureLabel.text = String(Int(weaatherStruct.main.tempMax))
        }
    }
}
