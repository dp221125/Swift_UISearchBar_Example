//
//  DetailViewController.swift
//  UISearchBarExample
//
//  Created by Meo MacBook Pro on 03/07/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var currency: String?

    var ownView: DetailView {
        return self.view as! DetailView
    }

    override func loadView() {
        self.view = DetailView()
    }

    override func viewDidLoad() {
        self.navigationItem.title = "화폐단위"
        self.ownView.currencyLabel.text = self.currency
    }
}
