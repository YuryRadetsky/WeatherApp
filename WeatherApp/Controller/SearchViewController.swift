//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 25.04.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var favoriteCity = UserSettings.shared.favoriteCity
    
    let networkService = NetworkService()
    var weatherStruct: WeatherStruct? = nil
    
    var delay: Timer?
    
    let gradient = Gradient()
    let image = Image()
    
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func tapSaveButton(_ sender: Any) {
        guard let city = searchBarr.searchTextField.text else {return}
        guard !city.isEmpty else {return}
        
        UserSettings.shared.favoriteCity.append("\(city)")
        UserSettings.shared.saveToDefaults()
        print(UserSettings.shared.favoriteCity)
    }
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var searchBarr: UISearchBar!
    
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
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //выводим в консоль вводимый текст(не будет показываться, пока не установим делегата)
        print(searchText)
        
        delay?.invalidate()
        delay = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            // чтобы избежать утечки памяти, нужно добавить [weak self]
            self.networkService.request(city: searchText) { [weak self] (result) in
                switch result {
                case .success(let weatherStruct):
                    print(weatherStruct.base.count, weatherStruct)
                    self?.weatherStruct = weatherStruct
                    
                    // UI Updates
                    self?.cityNameLabel.text = weatherStruct.name
                    self?.feelLikeLabel.text = "feels like \(Int(weatherStruct.main.feelsLike)) ℃"
                    self?.temperatureLabel.text = "\(Int(weatherStruct.main.temp))"
                    for weather in weatherStruct.weather {
                        //localizedUppercase - получаем стрингу капсом
                        self?.conditionLabel.text = weather.main.localizedUppercase
                        // conditionImage
                        self?.image.weatherCondition(weatherId: weather.id, imageView: self!.conditionImageView)
                        // Gradient background Updates
                        self?.gradient.setupBackgroundColor(weatherId: weather.id, viewController: self!)
                        
                        self?.descriptionWeather.text = weather.weatherDescription
                    }
                    
                    self?.min.text = "\(Int(weatherStruct.main.tempMin))℃"
                    self?.max.text = "\(Int(weatherStruct.main.tempMax))℃"
                    self?.pressure.text = "\(weatherStruct.main.pressure)hPa"
                    self?.humidity.text = "\(weatherStruct.main.humidity)%"
                    
                case .failure(let error):
                    print("error", error)
                }
            }
        })
        
    }
}
