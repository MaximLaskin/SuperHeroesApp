//
//  DetailsViewController.swift
//  SuperHeroes
//
//  Created by Maxim on 28.01.2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var placeOfBirthLabel: UILabel!

    var superHero: Superhero!
    
    private var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        fullNameLabel.text = superHero.biography.fullName
        placeOfBirthLabel.text = superHero.biography.placeOfBirth
        
        activityIndicator = showSpinner(in: imageView)
        fetchImage()
    }

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
