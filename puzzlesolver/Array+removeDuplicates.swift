//
//  Array+removeDuplicates.swift
//  puzzlesolver
//
//  Created by Rodrigo Guimaraes on 10/07/20.
//  Copyright © 2020 RodrigoLG. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    func removeDuplicates() -> [Int] {
        var result = self
        for index in (0..<self.count).reversed() {
            let arrayAlreadyContainsSameElementBefore = self[0..<index].contains(self[index])
            if arrayAlreadyContainsSameElementBefore { result.remove(at: index) }
        }
        return result
    }
}
