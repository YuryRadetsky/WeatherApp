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

final class LocationViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var feelLikeLabel: UILabel!
    @IBOutlet private weak var conditionImageView: UIImageView!
    @IBOutlet private weak var currentTemperatureLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var descriptionWeatherLabel: UILabel!
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    private let networkService = DataFetcherService()
    private let gradientBackground = GradientBackground()
    private let image = Image()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultValues()
        setupLocationManager()
        showLoader()
        enlargeConditionImageView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setups
    
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
    
    // MARK: - Loader
    
    private func showLoader() {
        loader.startAnimating()
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.color = .white
    }
    
    private func hideLoader() {
        loader.stopAnimating()
    }
    
    // MARK: - Animations
    
    private func enlargeConditionImageView() {
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let scale: CGFloat = 2
            self.conditionImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { _ in
            self.reduceConditionImageView()
        })
    }
    
    private func reduceConditionImageView() {
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let scale: CGFloat = 1
            self.conditionImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
    
}

// MARK: - Location Manager Delegate
extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkService.fetchWeatherData(latitude: latitude, longitude: longitude) { [weak self] (weather) in
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
        locationManager.stopUpdatingLocation()
        hideLoader()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Can't get location", error)
    }
    
}
