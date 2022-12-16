//
//  HeroCollectionViewCell.swift
//  SuperHeroes
//
//  Created by Maxim on 16.12.2022.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLamel: UILabel!

    private var activityIndicator: UIActivityIndicatorView?

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: imageView)
    }

    func configure(with superhero: Superhero) {
        nameLamel.text = superhero.name

        guard let url = URL(string: superhero.images.lg) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating()
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }

    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true

        view.addSubview(activityIndicator)

        return activityIndicator
    }
}
