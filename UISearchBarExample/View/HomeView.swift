//
//  HomeView.swift
//  UISearchBarExample
//
//  Created by Meo MacBook Pro on 03/07/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    let mainTableView: UITableView = {
        let mainTableView = UITableView()
        mainTableView.tableFooterView = UIView()
       return mainTableView
    }()
    
    func mainTableViewConstraint() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    func addViewItem() {
        addSubview(mainTableView)
    }
    
    func addViewConstraint() {
        mainTableViewConstraint()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViewItem()
        addViewConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
