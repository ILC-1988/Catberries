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

    func setConstraints(for view: UIView,
                        leadingAnchor: NSLayoutXAxisAnchor? = nil,
                        trailingAnchor: NSLayoutXAxisAnchor? = nil,
                        topAnchor: NSLayoutYAxisAnchor? = nil,
                        bottomAnchor: NSLayoutYAxisAnchor? = nil,
                        leadingConstant: CGFloat = 0,
                        trailingConstant: CGFloat = 0,
                        topConstant: CGFloat = 0,
                        bottomConstant: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false

        if let leadingAnchor = leadingAnchor {
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant).isActive = true
        }
        if let trailingAnchor = trailingAnchor {
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant).isActive = true
        }
        if let topAnchor = topAnchor {
            view.topAnchor.constraint(equalTo: topAnchor, constant: topConstant).isActive = true
        }
        if let bottomAnchor = bottomAnchor {
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant).isActive = true
        }
    }

}

// MARK: cornerRadius
extension UIView {
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
    }

    var radius: CGFloat {
        get {
            layer.cornerRadius
        }

        set {
            makeRoundCorners(with: newValue)
        }
    }

    var diameter: CGFloat {
        get {
            self.layer.cornerRadius * 2
        }

        set {
            makeRoundCorners(with: newValue / 2)
        }
    }

    func makeRoundCorners(with radius: CGFloat = 30) {
        layer.cornerRadius = frame.width * 0.1
    }

    func setShadow() {
        layer.shadowColor = UIColor.systemMint.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20
        layer.shadowOffset = .zero
        layer.shadowPath = CGPath(roundedRect: bounds,
                                       cornerWidth: cornerRadius,
                                       cornerHeight: cornerRadius,
                                       transform: nil)
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func setElementAppearance() {
        makeRoundCorners()
        setShadow()
    }
}
