//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 25.04.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let networkService = NetworkService()
    var weatherStruct: WeatherStruct? = nil
    
    let gradient = Gradient()
    let image = Image()
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var temperatureView: UIView!
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var searchBarr: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.text = "City"
        feelLikeLabel.text = "feels like -- ℃"
        conditionImageView.image = UIImage(named: "icon_na")
        temperatureLabel.text = "--"
        conditionLabel.text = "CONDITION"
        
    }
    
    
    //Gradient background
//    func setupGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [UIColor(red: 145/255, green: 85/255, blue: 205/255, alpha: 1).cgColor,
//                                UIColor(red: 100/255, green: 90/255, blue: 230/255, alpha: 1).cgColor]
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //выводим в консоль вводимый текст(не будет показываться, пока не установим делегата)
        print(searchText)
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(searchText)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        
             // чтобы избежать утечки памяти, нужно добавить [weak self]
             networkService.request(urlString: urlString) { [weak self] (result) in
                 switch result {
                 case .success(let weatherStruct):
                     print(weatherStruct.base.count, weatherStruct)
                     self?.weatherStruct = weatherStruct
                     
                     // UI Updates
                     self?.cityNameLabel.text = weatherStruct.name
                     self?.feelLikeLabel.text = "feels like \(weatherStruct.main.feelsLike) ℃"
                     self?.temperatureLabel.text = "\(weatherStruct.main.temp)"
                     for weather in weatherStruct.weather {
                         //localizedUppercase - получаем стрингу капсом
                        self?.conditionLabel.text = weather.main.localizedUppercase
                        // conditionImage
                        self?.image.weatherCondition(weatherId: weather.id, imageView: self!.conditionImageView)
                        // Gradient background Updates
                        self?.gradient.setupBackgroundColor(weatherId: weather.id, viewController: self!)
                        
                     }
                     
                 case .failure(let error):
                     print("error", error)
                 }
             }
    }
}
