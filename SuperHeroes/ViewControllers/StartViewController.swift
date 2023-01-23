//
//  StartViewController.swift
//  SuperHeroes
//
//  Created by Maxim on 08.01.2023.
//

import UIKit

final class StartViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var versionAppLabel: UILabel!
    @IBOutlet var showButton: UIButton!

    // MARK: - Private properties
    private var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    // MARK: - LifeCicle View
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods
    private func setupView() {
        setupAppVersion()
        view.addVerticalGradientLayer()
    }

    private func setupAppVersion() {
        versionAppLabel.text = "Version \(appVersion ?? "1.1.0")"
        versionAppLabel.alpha = 0.4
    }
}
