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
    private var activityIndicator: UIActivityIndicatorView?

    // MARK: - LifeCicle View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        activityIndicator = showSpinner(in: view)
//        animateTableView()
        fetchSuperheroes()


        setupNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTableView()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        animateTableView()
    }


    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        superHeroes.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        HeroTableViewCell().tableViewHeight
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HeroTableViewCell else { return UITableViewCell() }

        let superHero = superHeroes[indexPath.row]

        cell.configure(with: superHero)
        let tableViewHight = tableView.bounds.height
        var delay: Double = 0
        
        cell.transform = CGAffineTransform(translationX: 0, y: tableViewHight)
        UIView.animate(withDuration: 0.7,
                       delay: delay * 0.05,
                       options: .curveEaseInOut,
                       animations: {
            cell.transform = CGAffineTransform.identity
        },
                       completion: nil)
        delay += 1

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
    private func setupNavigationBar() {
        title = "SuperHeroes"

        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundEffect = UIBlurEffect(style: .extraLight) // доработать?

        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor(
            red: 31/255,
            green: 101/255,
            blue: 192/255,
            alpha: 200/255
        )

        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

     private func fetchSuperheroes() {
        NetworkManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let superHeroes):
                self?.superHeroes = superHeroes
                self?.activityIndicator?.stopAnimating()
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SuperHeroesListViewController {
    func animateTableView() {
        tableView.reloadData()

        let cell = tableView.visibleCells
        let tableViewHight = tableView.bounds.height
        var delay: Double = 0

        for cell in cell {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHight)
            UIView.animate(withDuration: 0.7,
                           delay: delay * 0.05,
                           options: .curveEaseInOut,
                           animations: {
                cell.transform = CGAffineTransform.identity
            },
                           completion: nil)
            delay += 1
        }
    }
}
