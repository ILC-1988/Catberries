//
//  UIViewController+Extension.swift
//  Catberries
//
//  Created by Илья Черницкий on 5.09.23.
//

import UIKit

extension UIViewController {
    func addHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
