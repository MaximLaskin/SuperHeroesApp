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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    private func setupRefreshControl() {
//        refreshControl = UIRefreshControl()
//        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl?.addTarget(self, action: #selector(fetchSuperheroes), for: .valueChanged)
//    }

     private func fetchSuperheroes() {
        NetworkManager.shared.fetchData { result in // получили массив result, который должны передать в superheroes
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
