//
//  SuperHeroesListViewController.swift
//  SuperHeroes
//
//  Created by Maxim on 26.01.2023.
//

import UIKit

final class SuperHeroesListViewController: UITableViewController {
    // MARK: - Private Properties
    private var superHeroes: [Superhero] = []

    // MARK: - LifeCicle View
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        view.backgroundColor = .black
        fetchSuperheroes()
//        setupRefreshControl()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        superHeroes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HeroTableViewCell else { return UITableViewCell() }

        let superHero = superHeroes[indexPath.row]

        cell.configure(with: superHero)
        return cell
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.superHero = superHeroes[indexPath.row]
    }


//    private func setupRefreshControl() {
//        refreshControl = UIRefreshControl()
//        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl?.addTarget(self, action: #selector(fetchSuperheroes), for: .valueChanged)
//    }

     private func fetchSuperheroes() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let superHeroes):
                self.superHeroes = superHeroes
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
