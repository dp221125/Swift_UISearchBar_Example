//
//  ViewController.swift
//  UISearchBarExample
//
//  Created by Meo MacBook Pro on 03/07/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var country = countryData
    
    var ownView: HomeView {
        return self.view as! HomeView
    }
    
    func makeNavigationItem() {
        self.navigationItem.title = "국가들"
    }
    
    func registerTableView() {
        ownView.mainTableView.register(CountryNameCell.self, forCellReuseIdentifier: "CountryName")
    }
    
    func deSelectedRow() {
        
        if let index = ownView.mainTableView.indexPathForSelectedRow {
            ownView.mainTableView.deselectRow(at: index, animated: true)
        }
        
    }
    
    override func loadView() {
        let view = HomeView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationItem()
        registerTableView()
        ownView.mainTableView.dataSource = self
        ownView.mainTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        deSelectedRow()
    }


}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let nameCell = tableView.dequeueReusableCell(withIdentifier: "CountryName", for: indexPath) as? CountryNameCell {
            nameCell.accessoryType = .disclosureIndicator
            nameCell.titleLabel.text = country[indexPath.row].name
            nameCell.subTitleLabel.text = country[indexPath.row].capital
            return nameCell
        }
        
        return UITableViewCell()
    }
}
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = DetailViewController()
        detailViewController.currency = country[indexPath.row].currency
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
