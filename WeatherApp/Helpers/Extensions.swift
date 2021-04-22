//
//  Extensions.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 21.04.2021.
//  Copyright © 2021 YuryRadetsky. All rights reserved.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
