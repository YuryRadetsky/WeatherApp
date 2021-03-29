//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
//swiftlint:disable all

class FavoriteViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    // MARK: - Properties
    
    let networkService = DataFetcherService()
    let gradientBackground = GradientBackground()
    let image = Image()
    
    var cityName = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultValues()
        setupCustomNavigationBar()
        
        fetchFaviriteCity(city: cityName)
    }
    
    // MARK: - Private Methods
    
    private func setupDefaultValues() {
        cityNameLabel.text = "City"
        feelLikeLabel.text = "feels like -- ℃"
        currentTemperatureLabel.text = "--"
        minTemperatureLabel.text = "-- ℃"
        maxTemperatureLabel.text = "-- ℃"
        descriptionWeatherLabel.text = "description"
        
        conditionImageView.image = UIImage(named: "icon_na")
        
        view.backgroundColor = .systemGray2
    }
    
    private func setupCustomNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func fetchFaviriteCity (city: String ) {
        networkService.fetchWeatherData(forCity: city) { [weak self] (weather) in
            guard let weather = weather else { return }
            
            self?.cityNameLabel.text = weather.name
            self?.feelLikeLabel.text = "feels like \(String(Int(weather.main.feelsLike))) ℃"
            self?.minTemperatureLabel.text = "\(Int(weather.main.tempMin))"
            self?.maxTemperatureLabel.text = "\(Int(weather.main.tempMax))"
           
            self?.currentTemperatureLabel.text = "\(Int(weather.main.temp))"
            for weather in weather.weather {
                self?.descriptionWeatherLabel.text = weather.weatherDescription
                self?.image.weatherCondition(iconId: weather.icon, imageView: self!.conditionImageView)
                self?.gradientBackground.createGradientLayer(weatherId: weather.id, controller: self!)
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func refreshRapped(_ sender: UIBarButtonItem) {
        fetchFaviriteCity(city: cityName)
    }
    
}
