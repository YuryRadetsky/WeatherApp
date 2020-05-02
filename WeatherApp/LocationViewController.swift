//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 21.03.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    
    let networkService = NetworkService()
    var weatherStruct: WeatherStruct? = nil
    
    
    
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Gradient background
        //        setupGradient ()
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Minsk&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        
        // чтобы избежать утечки памяти, нужно добавить [weak self]
        networkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            // в случае успеха выполняются следующие действия:
            case .success(let weaatherStruct):
                print(weaatherStruct.base.count)
                self?.weatherStruct = weaatherStruct
                
                // UI Updates
                self?.cityNameLabel.text = weaatherStruct.name
                self?.feelLikeLabel.text = "feels like \(weaatherStruct.main.feelsLike) ℃"
                self?.temperatureLabel.text = "\(weaatherStruct.main.temp)"
                
                for weather in weaatherStruct.weather {
                    //localizedUppercase - получаем стрингу капсом 
                    self?.conditionLabel.text = weather.main.localizedUppercase
                    //                    self?.conditionLabel.text = weather.weatherDescription
                    print(weather.id)
                    self?.weatherCondition(weatherId: weather.id)
                    
                }
                
                // Gradient background Updates //
                self?.setupBackgroundColor(temperature: weaatherStruct.main.temp)
                
                
            // в случае успеха выполняются следующие действия:
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    //Gradient background
    func setupGradient() {
        //Gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor, UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Gradient background Updates
    func setupBackgroundColor(temperature: Int) {
        let temp = temperature
        
        // В зависимости от полученной температуры меняется backgroundColor
        switch temp {
        case ...0:
            self.view.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 1.00)
            print("...0")
        case 0...5:
            self.view.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
            print("0...5")
        case 5...10:
            self.view.backgroundColor = UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
            print("5...10")
        case 10...15:
            self.view.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 1.00)
            print("10...15")
        case 15...20:
            self.view.backgroundColor = UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00)
            print("15...20")
        case 20...25:
            self.view.backgroundColor = UIColor(red: 0.00, green: 0.42, blue: 0.46, alpha: 1.00)
            print("20...25")
        case 25...30:
            self.view.backgroundColor = UIColor(red: 0.75, green: 0.85, blue: 0.86, alpha: 1.00)
            print("25...30")
        case 30...:
            self.view.backgroundColor = UIColor(red: 0.33, green: 0.00, blue: 0.92, alpha: 1.00)
            print("30...")
        default:
            print("...")
        }
    }
    
    func weatherCondition(weatherId: Int) {
        let id = weatherId
        switch id {
        case 200...232:
            conditionImageView.image = UIImage(named: "icon_rain")
            print("Thunderstorm")
        case 300...321:
            conditionImageView.image = UIImage(named: "icon_rain")
            print("Drizzle")
        case 500...531:
            conditionImageView.image = UIImage(named: "icon_rain")
            print("Rain")
        case 600...622:
            conditionImageView.image = UIImage(named: "icon_snow")
            print("Snow")
        case 701...781:
            conditionImageView.image = UIImage(named: "icon_fog")
            print("Atmosphere")
        case 800:
            conditionImageView.image = UIImage(named: "icon_sun")
            print("Clear")
        case 801...804:
            conditionImageView.image = UIImage(named: "icon_fog")
            print("Clouds")
        default:
            conditionImageView.image = UIImage(named: "icon_na")
            print("")
        }
    }
    
    
}

