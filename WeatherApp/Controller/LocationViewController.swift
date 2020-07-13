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
    let networkService = NetworkService()
    var weatherStruct: WeatherStruct?
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
            networkService.request(latitude: latitude, longitude: longitude) { [weak self] (result) in
                switch result {
                    
                case .success(let weaatherStruct):
                    print(weaatherStruct.base.count)
                    self?.weatherStruct = weaatherStruct
                    // UI Updates
                    self?.cityNameLabel.text = weaatherStruct.name
                    self?.feelLikeLabel.text = "feels like \(Int(weaatherStruct.main.feelsLike)) ℃"
                    self?.temperatureLabel.text = "\(Int(weaatherStruct.main.temp))"
                    for weather in weaatherStruct.weather {
                        self?.conditionLabel.text = weather.main.localizedUppercase
                        self?.descriptionWeather.text = weather.weatherDescription
                        print(weather.id)
                        // Image Updates
                        self?.image.weatherCondition(weatherId: weather.id, imageView: self!.conditionImageView)
                        // Gradient background Updates
                        self?.gradient.setupBackgroundColor(weatherId: weather.id, viewController: self!)
                    }
                    self?.min.text = "\(Int(weaatherStruct.main.tempMin))℃"
                    self?.max.text = "\(Int(weaatherStruct.main.tempMax))℃"
                    self?.pressure.text = "\(weaatherStruct.main.pressure)hPa"
                    self?.humidity.text = "\(weaatherStruct.main.humidity)%"
                    
                case .failure(let error):
                    print("error", error)
                }
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Can't get location", error)
    }
    
}
