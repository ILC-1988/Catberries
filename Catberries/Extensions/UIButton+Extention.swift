//
//  UIButton+Extention.swift
//  Catberries
//
//  Created by Илья Черницкий on 24.08.23.
//

import UIKit

extension UIButton {
    static func setupButton(_ name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8123916293, green: 0.6769403526, blue: 0.8276493033, alpha: 1)
        let coller = #colorLiteral(red: 0.3435927882, green: 0.3164824535, blue: 0.0863634573, alpha: 1)
        button.setTitleColor(coller, for: .normal)
        button.titleLabel?.font = UIFont(name: "Kefa Regular", size: 24)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
