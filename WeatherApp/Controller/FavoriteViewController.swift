//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
//swiftlint:disable all

final class FavoriteViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var feelLikeLabel: UILabel!
    @IBOutlet private weak var conditionImageView: UIImageView!
    @IBOutlet private weak var currentTemperatureLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var descriptionWeatherLabel: UILabel!
    @IBOutlet private var backgroundView: UIView!
    
    // MARK: - Properties
    
    private let networkService = DataFetcherService()
    private let gradientBackground = GradientBackground()
    private let image = Image()
    
    var cityName = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultValues()
        setupCustomNavigationBar()
        fetchFaviriteCity(city: cityName)
    }
    
    // MARK: - Setups
    
    private func setupDefaultValues() {
        cityNameLabel.text = nil
        feelLikeLabel.text = nil
        currentTemperatureLabel.text = nil
        minTemperatureLabel.text = nil
        maxTemperatureLabel.text = nil
        descriptionWeatherLabel.text = nil
        
        conditionImageView.image = nil
        view.backgroundColor = .systemGray
    }
    
    private func setupCustomNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    // MARK: - Networking
    
    private func fetchFaviriteCity (city: String ) {
        networkService.fetchWeatherData(forCity: city) { [weak self] (weather) in
            guard let self = self,
                  let weather = weather else { return }
            self.cityNameLabel.text = weather.name
            self.feelLikeLabel.text = "Feels like " + String(format: "%.f", weather.main.feelsLike) + " ℃"
            self.minTemperatureLabel.text = String(format: "%.f", weather.main.tempMin)
            self.maxTemperatureLabel.text = String(format: "%.f", weather.main.tempMax)
            self.currentTemperatureLabel.text = String(format: "%.f", weather.main.temp)
            self.descriptionWeatherLabel.text = weather.weather[0].weatherDescription.localizedCapitalized
            self.image.weatherCondition(iconId: weather.weather[0].icon, imageView: self.conditionImageView)
            self.gradientBackground.createGradientLayer(weatherId: weather.weather[0].id, controller: self)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction private func refreshRapped(_ sender: UIBarButtonItem) {
        fetchFaviriteCity(city: cityName)
    }
    
}
