//
//  ViewController.swift
//  SuperHeroes
//
//  Created by Maxim on 16.12.2022.
//

import UIKit

final class SuperHeroesListController: UICollectionViewController {

    // MARK: Private Properties
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

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let superHeroe = superHeroes[indexPath.item]
//
//        performSegue(withIdentifier: "details", sender: nil)
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let
//    }
    
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

extension SuperHeroesListController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 40, height: 500)
    }
}

