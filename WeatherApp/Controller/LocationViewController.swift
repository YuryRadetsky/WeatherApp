//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 21.03.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    //    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Minsk&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
    
    let locationManager = CLLocationManager()
    let networkService = NetworkService()
    var weatherStruct: WeatherStruct? = nil
    
    let gradient = Gradient()
    let image = Image()
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
//                setupRequest()
        
    }
    
    
    
    func setupRequest() {
        // чтобы избежать утечки памяти, нужно добавить [weak self]
        networkService.request(city: "Minsk") { [weak self] (result) in
            switch result {
            // в случае успеха выполняется действие:
            case .success(let weaatherStruct):
                print(weaatherStruct.base.count)
                self?.weatherStruct = weaatherStruct
                // UI Updates
                self?.cityNameLabel.text = weaatherStruct.name
                self?.feelLikeLabel.text = "feels like \(Int(weaatherStruct.main.feelsLike)) ℃"
                self?.minMaxTempLabel.text = "\(weaatherStruct.main.tempMin)˚/ \(weaatherStruct.main.tempMax)˚"
                self?.temperatureLabel.text = "\(weaatherStruct.main.temp)"
                
                for weather in weaatherStruct.weather {
                    //localizedUppercase - получаем стрингу капсом
                    self?.conditionLabel.text = weather.main.localizedUppercase
                    print(weather.id)
                    // Image Updates
                    self?.image.weatherCondition(weatherId: weather.id, imageView: self!.conditionImageView)
                    // Gradient background Updates //
                    self?.gradient.setupBackgroundColor(weatherId: weather.id, viewController: self!)
                }
                
            // в случае провала выполняется действие:
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        //kCLLocationAccuracyBest используем, когда нам нужна очень высокая точность, но не нужен тот же уровень точности, который требуется для навигационных приложений
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // requestWhenInUseAuthorization() Запрашивает у пользователя разрешение на использование служб определения местоположения во время использования приложения.
        locationManager.requestWhenInUseAuthorization()
        //startUpdatingLocation() вызов этого метода заставляет locationManager получить начальное местоположения
        locationManager.startUpdatingLocation()
    }
    
    
    
    //MARK: - CLLocationManagerDelegate
    
    //Сообщает делегату, что доступны новые данные о местоположении.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//                print(manager.location)
        //получаем текущие координаты устройства
        if let location = locations.last {
            print(location)
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print(latitude,longitude)
            
            //            let apiUrl = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
            //            print(apiUrl)
            
            networkService.request(latitude: latitude, longitude: longitude) { [weak self] (result) in
                switch result {
                // в случае успеха выполняется действие:
                case .success(let weaatherStruct):
                    print(weaatherStruct.base.count)
                    self?.weatherStruct = weaatherStruct
                    // UI Updates
                    self?.cityNameLabel.text = weaatherStruct.name
                    self?.feelLikeLabel.text = "feels like \(Int(weaatherStruct.main.feelsLike)) ℃"
                    self?.minMaxTempLabel.text = "\(weaatherStruct.main.tempMin)˚/ \(weaatherStruct.main.tempMax)˚"
                    self?.temperatureLabel.text = "\(weaatherStruct.main.temp)"
                    
                    for weather in weaatherStruct.weather {
                        //localizedUppercase - получаем стрингу капсом
                        self?.conditionLabel.text = weather.main.localizedUppercase
                        print(weather.id)
                        // Image Updates
                        self?.image.weatherCondition(weatherId: weather.id, imageView: self!.conditionImageView)
                        // Gradient background Updates //
                        self?.gradient.setupBackgroundColor(weatherId: weather.id, viewController: self!)
                    }
                    
                // в случае провала выполняется действие:
                case .failure(let error):
                    print("error", error)
                }
            }
            
        }
        
        
        //stopUpdatingLocation() останавливаем обновление локации
        locationManager.stopUpdatingLocation()
    }
    
    //Сообщает делегату, что locationManager не получил значение местоположения.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Can't get location",error)
    }
    
}

