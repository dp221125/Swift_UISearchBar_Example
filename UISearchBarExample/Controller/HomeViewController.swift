//
//  ViewController.swift
//  UISearchBarExample
//
//  Created by Meo MacBook Pro on 03/07/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class HomeViewController: UIViewController {
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        return searchController
    }()

    private var country = countryData
    private var filteredCountry = [Country]()
    private var disposeBag = DisposeBag()

    private var ownView: HomeView {
        return self.view as! HomeView
    }

    private func makeNavigationItem() {
        self.navigationItem.title = "국가들"
    }

    private func registerTableView() {
        self.ownView.mainTableView.register(CountryNameCell.self, forCellReuseIdentifier: "CountryName")
    }

    private func deSelectedRow() {
        if let index = ownView.mainTableView.indexPathForSelectedRow {
            self.ownView.mainTableView.deselectRow(at: index, animated: true)
        }
    }

    private func rxSearch() {
        self.searchController.searchBar.rx.text.orEmpty
            .map { searchKeyword in
                self.filteredCountry = self.country.filter { (country: Country) -> Bool in
                    country.name.contains(searchKeyword) || country.capital.contains(searchKeyword)
                }
            }
            .subscribe(onNext: {
                self.ownView.mainTableView.reloadData()
            })
            .disposed(by: self.disposeBag)
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
        self.rxSearch()
        self.navigationItem.searchController = self.searchController
    }

    override func viewWillAppear(_: Bool) {
        self.deSelectedRow()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if self.filteredCountry.count > 0 {
            return self.filteredCountry.count
        }
        return self.country.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let nameCell = tableView.dequeueReusableCell(withIdentifier: "CountryName", for: indexPath) as? CountryNameCell {
            nameCell.accessoryType = .disclosureIndicator

            if self.filteredCountry.count > 0 {
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

        if self.filteredCountry.count > 0 {
            detailViewController.currency = self.filteredCountry[indexPath.row].currency
        }

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
