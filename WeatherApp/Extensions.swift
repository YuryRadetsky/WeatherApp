//
//  Extensions.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.03.2021.
//  Copyright © 2021 YuryRadetsky. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
