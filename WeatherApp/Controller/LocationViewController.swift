//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 21.03.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
import CoreLocation
//swiftlint:disable trailing_whitespace
//swiftlint:disable vertical_whitespace
//swiftlint:disable line_length

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    let locationManager = CLLocationManager()
    let networkService = DataFetcherService()
    let gradient = GradientBackground()
    let image = Image()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultValues()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print(location)
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print(latitude, longitude)
            networkService.fetchWeatherData(latitude: latitude, longitude: longitude) { [weak self] (weaatherStruct) in
                guard let weaatherStruct = weaatherStruct else { return }
                // UI Updates
                self?.cityNameLabel.text = weaatherStruct.name
                self?.feelLikeLabel.text = "feels like " + String(Int(weaatherStruct.main.feelsLike)) + " ℃"
                self?.currentTemperatureLabel.text = "\(Int(weaatherStruct.main.temp))"
                for weather in weaatherStruct.weather {
                    self?.descriptionWeatherLabel.text = weather.weatherDescription
                    print(weather.id)
                    // Image Updates
                    self?.image.weatherCondition(iconId: weather.icon, imageView: self!.conditionImageView)
                    // Gradient background Updates
                    self?.gradient.createGradientLayer(weatherId: weather.id, controller: self!)
                }
                self?.minTemperatureLabel.text = String(Int(weaatherStruct.main.tempMin))
                self?.maxTemperatureLabel.text = String(Int(weaatherStruct.main.tempMax))
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Can't get location", error)
    }
}
