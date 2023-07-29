//
//  UIView+Extension .swift
//  Catberries
//
//  Created by Илья Черницкий on 30.07.23.
//

import UIKit.UIView

// MARK: Constraints
extension UIView {
    
    func setupConstraints(for view: UIView, in superview: UIView, with margins: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: margins.top),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margins.left),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -margins.right),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -margins.bottom)
        ])
        
    }
  
}
