//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 25.04.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import Foundation
import CoreLocation
//swiftlint:disable trailing_whitespace
//swiftlint:disable line_length
//swiftlint:disable unused_closure_parameter

class NetworkService {
    let locationManager = CLLocationManager()
    
    /*
      C 5 версии swift вышел спечиальный тип Result.
      Result принимает в себя два объекта (два дженерика).
      Первый объект отвечает за тот тип, который мы получили, второй объект отвечает за ошибку.
      Для того, чтобы completion возвращал значения из вне, используем @escaping.
      */
    func request (city: String, completion: @escaping (Result<WeatherStruct, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        print("URL string: city - ", urlString)
        
        guard let url = URL(string: urlString) else {return}
        
        /*
         При помощи класса URLSession мы запрашиваем данные. На вход подаем наш url, а на выходе получаем completionHandler,
         который передает data, которую мы получи, + response и error
         */
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // ниже мы указываем, что будем делать с датой, которая к нам приходит
            guard let data = data else {return}
            guard error == nil else {return}
            //парсинг необходимо проделывать в блоке do catch
            do {
                /* в первый параметр вставляем свою модель данных (структуру), которую мы хотим переконвертировать в наш json ответ.
                 Во второй параметр вставляем откуда мы будем брать данные (data)*/
                let weatherData = try JSONDecoder().decode(WeatherStruct.self, from: data)
                //мы не можем перекрывать основной поток. Подгрузка данных должна реализовываться в асинхронном потоке. Для этого вызываем DispatchQueue.main.async
                DispatchQueue.main.async {
                    completion(.success(weatherData))
                }
                
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
            }
        } .resume()
    }
    
    func request (latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherStruct, Error>) -> Void) {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        print("URL string: location - ", urlString)
        
        guard let url = URL(string: urlString) else {return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherStruct.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weatherData))
                }
            } catch let jsonError {
                print("Failed to decode JSON ", jsonError)
            }
        } .resume()
    }
}
