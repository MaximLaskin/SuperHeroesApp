//
//  DetailsViewController.swift
//  SuperHeroes
//
//  Created by Maxim on 28.01.2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var placeOfBirthLabel: UILabel!

    // MARK: - Properties
    var superHero: Superhero!

    // MARK: -  Private properties
    private var activityIndicator: UIActivityIndicatorView?

    // MARK: - LifeCicle View
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .black
        title = superHero.name

        if superHero.biography.fullName != "" {
            fullNameLabel.text = superHero.biography.fullName
        } else {
            fullNameLabel.text = superHero.name
        }

        if superHero.biography.placeOfBirth != "-" {
            placeOfBirthLabel.text = superHero.biography.placeOfBirth
        } else {
            placeOfBirthLabel.text = "unknow"
        }
        
        activityIndicator = showSpinner(in: imageView)
        fetchImage()
    }

    // MARK: - Networking
    private func fetchImage() {
        activityIndicator?.startAnimating()
        NetworkManager.shared.fetchImage1(from: superHero.images.lg) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                self.imageView.image = image
                self.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
