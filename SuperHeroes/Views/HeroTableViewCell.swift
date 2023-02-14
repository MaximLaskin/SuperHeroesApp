//
//  HeroTableViewCell.swift
//  SuperHeroes
//
//  Created by Maxim on 26.01.2023.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var publisherLabel: UILabel!

    @IBOutlet var heroImageView: UIImageView! {
        didSet {
            heroImageView.contentMode = .scaleAspectFill
            heroImageView.clipsToBounds = true
            heroImageView.layer.cornerRadius = 10
            heroImageView.backgroundColor = .black
        }
    }

    var tableViewHeight: CGFloat = 80
    // MARK: - Private Properties

    private var activityIndicator: UIActivityIndicatorView?

    private var imageURL: URL? {
        didSet {
            heroImageView.image = UIImage(named: "batman_2")
            updateImage()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        activityIndicator = showSpinner(in: heroImageView)
    }

    // MARK: - Public methods
    func configure(with superHero: Superhero) {
        nameLabel.text = superHero.name
        publisherLabel.text = superHero.biography.publisher

        imageURL = URL(string: superHero.images.lg)
    }

    // MARK: - Private methods
    private func updateImage() {
        activityIndicator?.startAnimating()
        guard let url = imageURL else { return }
        getImage(from: url) { [unowned self] result in
            switch result {
            case .success(let image):
                if url == self.imageURL {
                    self.heroImageView.image = image
                    self.activityIndicator?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cachedImage))
            return
        }
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
