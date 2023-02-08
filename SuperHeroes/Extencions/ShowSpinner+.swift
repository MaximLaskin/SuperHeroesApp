//
//  ShowSpinner+.swift
//  SuperHeroes
//
//  Created by Maxim on 28.01.2023.
//


import UIKit

func showSpinner(in view: UIView) -> UIActivityIndicatorView {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .white
    activityIndicator.startAnimating()
    activityIndicator.center = view.center
    activityIndicator.hidesWhenStopped = true

    view.addSubview(activityIndicator)

    return activityIndicator
}
