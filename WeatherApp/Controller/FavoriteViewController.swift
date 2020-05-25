//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let networkService = NetworkService()
    var weatherStruct: WeatherStruct? = nil
    
    let gradient = Gradient()
    let image = Image()
    
    var city = ""
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
        
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var descriptionWeather: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.text = "City"
        feelLikeLabel.text = "feels like -- ℃"
        conditionImageView.image = UIImage(named: "icon_na")
        temperatureLabel.text = "--"
        conditionLabel.text = "CONDITION"
        view.backgroundColor = .systemGray2
        
        min.text = "--℃"
        max.text = "--℃"
        pressure.text = "--hPa"
        humidity.text = "--%"
        descriptionWeather.text = "description"
        fetchFaviriteCity(city: city)
        
    }
    
    
    func fetchFaviriteCity (city: String ) {
        networkService.request(city: city) { [weak self](result) in
            switch result {
            // в случае успеха выполняется действие:
            case .success(let weaatherStruct):
                print(weaatherStruct.base.count)
                self?.weatherStruct = weaatherStruct
                // UI Updates
                self?.cityNameLabel.text = weaatherStruct.name
                self?.feelLikeLabel.text = "feels like \(Int(weaatherStruct.main.feelsLike)) ℃"
                self?.temperatureLabel.text = "\(Int(weaatherStruct.main.temp))"
                
                for weather in weaatherStruct.weather {
                    //localizedUppercase - получаем стрингу капсом
                    self?.conditionLabel.text = weather.main.localizedUppercase
                    print(weather.id)
                    // Image Updates
                    self?.image.weatherCondition(weatherId: weather.id, imageView: self!.conditionImageView)
                    // Gradient background Updates //
                    self?.gradient.setupBackgroundColor(weatherId: weather.id, viewController: self!)
                    
                    self?.descriptionWeather.text = weather.weatherDescription
                }
                
                self?.min.text = "\(Int(weaatherStruct.main.tempMin))℃"
                self?.max.text = "\(Int(weaatherStruct.main.tempMax))℃"
                self?.pressure.text = "\(weaatherStruct.main.pressure)hPa"
                self?.humidity.text = "\(weaatherStruct.main.humidity)%"
                
                
            // в случае провала выполняется действие:
            case .failure(let error):
                print("error", error)
            }
        }
        
    }
    
    
}

