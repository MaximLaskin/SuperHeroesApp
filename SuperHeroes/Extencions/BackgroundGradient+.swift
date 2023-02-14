//
//  BackgroundGradient+.swift
//  SuperHeroes
//
//  Created by Maxim on 06.01.2023.
//

import UIKit

// MARK: - Set background color
extension UIView {
    func addVerticalGradientLayer() {
        let primaryColor = UIColor(
            red: 28/255,
            green: 58/255,
            blue: 86/255,
            alpha: 1
        )

        let secondaryColor = UIColor(
            red: 13/255,
            green: 30/255,
            blue: 38/255,
            alpha: 1
        )

        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [primaryColor.cgColor, secondaryColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}
