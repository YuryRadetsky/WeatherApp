//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 21.03.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
import CoreLocation
//import SDWebImage
//swiftlint:disable all

class LocationViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    let networkService = DataFetcherService()
    let gradientBackground = GradientBackground()
    let image = Image()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultValues()
        setupLocationManager()
        showLoader()
    }
    
    // MARK: - Private Methods
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
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
    
    private func showLoader() {
        loader.startAnimating()
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.color = .white
    }
    
    private func hideLoader() {
        loader.stopAnimating()
    }
    
}

// MARK: - Location Manager Delegate
extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkService.fetchWeatherData(latitude: latitude, longitude: longitude) { [weak self] (weather) in
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
        locationManager.stopUpdatingLocation()
        hideLoader()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Can't get location", error)
    }
    
}
