//
//  DetailView.swift
//  UISearchBarExample
//
//  Created by Meo MacBook Pro on 03/07/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit

class DetailView: UIView {
    let currencyLabel: UILabel = {
        let currencyLabel = UILabel()
        currencyLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return currencyLabel
    }()

    func currencyLabelConstraint() {
        self.currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(self.currencyLabel)
        self.currencyLabelConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
