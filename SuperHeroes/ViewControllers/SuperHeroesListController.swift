//
//  ViewController.swift
//  SuperHeroes
//
//  Created by Maxim on 16.12.2022.
//

import UIKit

final class SuperHeroesListController: UICollectionViewController {

    private var superHeroes: [Superhero] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSuperHeroes()
    }

// MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        superHeroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCollectionViewCell
        let superhero = superHeroes[indexPath.row]
        cell.configure(with: superhero)
        return cell
    }

    
    private func fetchSuperHeroes() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let superheroes):
                self.superHeroes = superheroes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

    }
}

