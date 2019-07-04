//
//  ViewController.swift
//  UISearchBarExample
//
//  Created by Meo MacBook Pro on 03/07/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private var country = countryData
    private var filteredCountry = [Country]()

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        return searchController
    }()

    private var ownView: HomeView {
        return view as! HomeView
    }

    private func makeNavigationItem() {
        navigationItem.title = "국가와 화폐"
        navigationItem.searchController = self.searchController
    }

    private func filterContentForSearchKeyWord(_ searchKeyword: String) {
        self.filteredCountry = self.country.filter { (country: Country) -> Bool in

            country.name.contains(searchKeyword) || country.capital.contains(searchKeyword)
        }
        self.ownView.mainTableView.reloadData()
    }

    private func registerTableView() {
        self.ownView.mainTableView.register(CountryNameCell.self, forCellReuseIdentifier: "CountryName")
    }

    private func deSelectedRow() {
        if let index = ownView.mainTableView.indexPathForSelectedRow {
            self.ownView.mainTableView.deselectRow(at: index, animated: true)
        }
    }

    override func loadView() {
        let view = HomeView()
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeNavigationItem()
        self.registerTableView()
        self.ownView.mainTableView.dataSource = self
        self.ownView.mainTableView.delegate = self
        self.searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }

    override func viewWillAppear(_: Bool) {
        self.deSelectedRow()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if self.searchController.isActive {
            return self.filteredCountry.count
        }
        return self.country.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let nameCell = tableView.dequeueReusableCell(withIdentifier: "CountryName", for: indexPath) as? CountryNameCell {
            nameCell.accessoryType = .disclosureIndicator

            if self.searchController.isActive {
                nameCell.titleLabel.text = self.filteredCountry[indexPath.row].name
                nameCell.subTitleLabel.text = self.filteredCountry[indexPath.row].capital
            } else {
                nameCell.titleLabel.text = self.country[indexPath.row].name
                nameCell.subTitleLabel.text = self.country[indexPath.row].capital
            }
            return nameCell
        }

        fatalError()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.currency = self.country[indexPath.row].currency

        if self.searchController.isActive {
            detailViewController.currency = self.filteredCountry[indexPath.row].currency
        }

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKeyword = searchController.searchBar.text else {
            return
        }
        self.filterContentForSearchKeyWord(searchKeyword)
    }
}
