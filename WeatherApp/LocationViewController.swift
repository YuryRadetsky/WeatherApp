//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 21.03.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
import CoreLocation
//swiftlint:disable vertical_whitespace
//swiftlint:disable trailing_whitespace

class LocationViewController: UIViewController {
    
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Minsk&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
    
    let networkService = NetworkService()
    var weatherStruct: WeatherStruct?
    
    var gradient = Gradient()
    var image = Image()
    
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
        
        // чтобы избежать утечки памяти, нужно добавить [weak self]
        networkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            
            // в случае успеха выполняются действия:
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
                    print(weather.id)
                    // Image Updates
                    self?.image.weatherCondition(weatherId: weather.id)
                    // Gradient background Updates
                    self?.gradient.setupBackgroundColor(weatherId: weather.id)
                }
                
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
}
