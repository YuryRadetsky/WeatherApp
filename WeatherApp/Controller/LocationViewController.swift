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
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    
    let locationManager = CLLocationManager()
    let networkService = DataFetcherService()
    var weatherStruct: WeatherModel?
    let gradient = Gradient()
    let image = Image()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = "City"
        feelLikeLabel.text = "feels like -- ℃"
        conditionImageView.image = UIImage(named: "icon_na")
        temperatureLabel.text = "--"
        conditionLabel.text = "CONDITION"
        min.text = "--℃"
        max.text = "--℃"
        pressure.text = "--hPa"
        humidity.text = "--%"
        descriptionWeather.text = "description"
        view.backgroundColor = .systemGray2
        setupLocationManager()
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
                print(weaatherStruct.base.count)
                // UI Updates
                self?.cityNameLabel.text = weaatherStruct.name
                self?.feelLikeLabel.text = "feels like " + String(Int(weaatherStruct.main.feelsLike)) + " ℃"
                self?.temperatureLabel.text = "\(Int(weaatherStruct.main.temp))"
                for weather in weaatherStruct.weather {
                    self?.conditionLabel.text = weather.main.localizedUppercase
                    self?.descriptionWeather.text = weather.weatherDescription
                    print(weather.id)
                    // Image Updates
                    self?.image.weatherCondition(iconId: weather.icon, imageView: self!.conditionImageView)
                    // Gradient background Updates
                    self?.gradient.createGradientLayer(weatherId: weather.id, viewController: self!)
                }
                self?.min.text = String(Int(weaatherStruct.main.tempMin)) + " ℃"
                self?.max.text = String(Int(weaatherStruct.main.tempMax)) + " ℃"
                self?.pressure.text = String(weaatherStruct.main.pressure) + " hPa"
                self?.humidity.text = String(weaatherStruct.main.humidity) + " %"
            }
        }
        locationManager.stopUpdatingLocation()
    }
}

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Can't get location", error)
}
