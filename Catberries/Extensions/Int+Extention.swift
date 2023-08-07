//
//  File.swift
//  Catberries
//
//  Created by Илья Черницкий on 6.08.23.
//

import Foundation

extension Int {

    func format() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        if let formattedNumber = formatter.string(from: NSNumber(value: self)) {
            return formattedNumber
        } else {
            return String(self)
        }
    }

}
