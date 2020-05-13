//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 25.04.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkService {
    let locationManager = CLLocationManager()
    
    // для того, чтобы completion возвращал значения из вне, нам нужно написать ключевое слово @escaping.
    // с 5 версии swift вышел спечиальный тип Result и мы можем писать не func request (urlString: String, completion: @escaping (WeatherStruct?, Error?) -> Void), а func request (urlString: String, completion: @escaping (Result<WeatherStruct, Error>) -> Void).  Result принимает в себя два объекта  ( два дженерика), где первый отвечает за тот тип, который мы получили, а второй за ошибку
    func request (urlString: String, completion: @escaping (Result<WeatherStruct, Error>) -> Void){
        
        guard let url = URL(string: urlString) else {return }
        
        // при помощи класса URLSession мы запрашиваем наши данные. На вход подаем наш url, а на выходе получаемcompletionHandler, который передает дату, которую мы получи, + респонс и ошибку
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // ниже мы указываем, что будем делать с датой, которая к нам приходит
            
            //мы не можем перекрывать основной поток. Подгрузка данных должна реализовываться в асинхронном потоке. Для этого вызываем DispatchQueue.main.async
            DispatchQueue.main.async {
                //проверяем пришла ли к нам ошибка
                if let error = error {
                    print("Some error")
                    //                    completion(nil, error)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {return}
                
                
                //парсинг необходимо проделывать в блоке do catch
                do {
                    // в первый параметр вставляем свою модель данных (структуру), которую мы хотим переконвертировать в наш json ответ. Во второй параметр вставляем откуда мы будем брать данные (data)
                    let weatherData = try JSONDecoder().decode(WeatherStruct.self, from: data)
                    //                    completion(weatherData, nil )
                    completion(.success(weatherData))
                    
                } catch let jsonError {
                    print("Failed to decode JSON ", jsonError)
                    //                        completion(nil, jsonError)
                    completion(.failure(jsonError))
                }
            }
        } .resume()
    }
    
    
    // для того, чтобы completion возвращал значения из вне, нам нужно написать ключевое слово @escaping.
     // с 5 версии swift вышел спечиальный тип Result и мы можем писать не func request (urlString: String, completion: @escaping (WeatherStruct?, Error?) -> Void), а func request (urlString: String, completion: @escaping (Result<WeatherStruct, Error>) -> Void).  Result принимает в себя два объекта  ( два дженерика), где первый отвечает за тот тип, который мы получили, а второй за ошибку
     func request (city: String, completion: @escaping (Result<WeatherStruct, Error>) -> Void){
         let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"

         guard let url = URL(string: urlString) else {return}
         
         // при помощи класса URLSession мы запрашиваем наши данные. На вход подаем наш url, а на выходе получаемcompletionHandler, который передает дату, которую мы получи, + респонс и ошибку
         URLSession.shared.dataTask(with: url) { (data, response, error) in
             // ниже мы указываем, что будем делать с датой, которая к нам приходит
             
             //мы не можем перекрывать основной поток. Подгрузка данных должна реализовываться в асинхронном потоке. Для этого вызываем DispatchQueue.main.async
             DispatchQueue.main.async {
                 //проверяем пришла ли к нам ошибка
                 if let error = error {
                     print("Some error")
                     //                    completion(nil, error)
                     completion(.failure(error))
                     return
                 }
                 
                 guard let data = data else {return}
                 
                 
                 //парсинг необходимо проделывать в блоке do catch
                 do {
                     // в первый параметр вставляем свою модель данных (структуру), которую мы хотим переконвертировать в наш json ответ. Во второй параметр вставляем откуда мы будем брать данные (data)
                     let weatherData = try JSONDecoder().decode(WeatherStruct.self, from: data)
                     //                    completion(weatherData, nil )
                     completion(.success(weatherData))
                     
                 } catch let jsonError {
                     print("Failed to decode JSON ", jsonError)
                     //                        completion(nil, jsonError)
                     completion(.failure(jsonError))
                 }
             }
         } .resume()
     }
    
    
    // для того, чтобы completion возвращал значения из вне, нам нужно написать ключевое слово @escaping.
    // с 5 версии swift вышел спечиальный тип Result и мы можем писать не func request (urlString: String, completion: @escaping (WeatherStruct?, Error?) -> Void), а func request (urlString: String, completion: @escaping (Result<WeatherStruct, Error>) -> Void).  Result принимает в себя два объекта  ( два дженерика), где первый отвечает за тот тип, который мы получили, а второй за ошибку
    func request (latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherStruct, Error>) -> Void){
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=da2798e7e8c96956caff9ac80cce3ebe"
        guard let url = URL(string: urlString) else {return }
        
        // при помощи класса URLSession мы запрашиваем наши данные. На вход подаем наш url, а на выходе получаемcompletionHandler, который передает дату, которую мы получи, + респонс и ошибку
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // ниже мы указываем, что будем делать с датой, которая к нам приходит
            
            //мы не можем перекрывать основной поток. Подгрузка данных должна реализовываться в асинхронном потоке. Для этого вызываем DispatchQueue.main.async
            DispatchQueue.main.async {
                //проверяем пришла ли к нам ошибка
                if let error = error {
                    print("Some error")
                    //                    completion(nil, error)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {return}
                
                
                //парсинг необходимо проделывать в блоке do catch
                do {
                    // в первый параметр вставляем свою модель данных (структуру), которую мы хотим переконвертировать в наш json ответ. Во второй параметр вставляем откуда мы будем брать данные (data)
                    let weatherData = try JSONDecoder().decode(WeatherStruct.self, from: data)
                    //                    completion(weatherData, nil )
                    completion(.success(weatherData))
                    
                } catch let jsonError {
                    print("Failed to decode JSON ", jsonError)
                    //                        completion(nil, jsonError)
                    completion(.failure(jsonError))
                }
            }
        } .resume()
    }
}
