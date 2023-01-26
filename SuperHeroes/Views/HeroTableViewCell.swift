//
//  HeroTableViewCell.swift
//  SuperHeroes
//
//  Created by Maxim on 26.01.2023.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var heroImageView: UIImageView!

    private var imageURL: URL?

    func configure(with superHero: Superhero) {
        nameLabel.text = superHero.name
        imageURL = URL(string: superHero.images.lg)
        NetworkManager.shared.fetchImage(from: superHero.images.lg) { [weak self] result in
            switch result {
            case .success(let imageData):
                    self.heroImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
