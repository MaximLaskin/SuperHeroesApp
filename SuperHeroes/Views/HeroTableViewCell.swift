//
//  HeroTableViewCell.swift
//  SuperHeroes
//
//  Created by Maxim on 26.01.2023.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var heroImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            heroImageView.contentMode = .scaleAspectFill
            heroImageView.clipsToBounds = true
            heroImageView.layer.cornerRadius = heroImageView.frame.height / 2
            heroImageView.backgroundColor = .white
        }
    }

    private var imageURL: URL? {
        didSet {
            heroImageView.image = UIImage(named: "logo")
            updateImage() // обновляем интерфейс, добавляем последнюю загружаемую.
        }
    }

    private var activityIndicator: UIActivityIndicatorView?

    override func awakeFromNib() { // подобие viewDidLoad, но в ячейке.
        super.awakeFromNib()
        activityIndicator = showSpinner(in: heroImageView)

    }

    // MARK: - Public methods
    func configure(with superHero: Superhero) {
        nameLabel.text = superHero.name

        imageURL = URL(string: superHero.images.lg) 

    }

    private func updateImage() {
        guard let url = imageURL else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                if url == self.imageURL {
                    self.activityIndicator?.stopAnimating()
                    self.heroImageView.image = UIImage(data: imageData)
                }
            }
        }
    }

    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white // цвет
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true

        view.addSubview(activityIndicator)

        return activityIndicator
    }
}
