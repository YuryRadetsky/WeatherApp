//
//  NetworkDataFetcher.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 23.03.2021.
//  Copyright © 2021 YuryRadetsky. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func fetchGenericData<T: Codable> (urlString: String, completion: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    
    func fetchGenericData<T: Codable>(urlString: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
            }
        }.resume()
    }
}
