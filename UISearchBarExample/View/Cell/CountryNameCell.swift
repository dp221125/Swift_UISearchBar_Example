//
//  CountryNameCell.swift
//  UISearchBarExample
//
//  Created by Meo MacBook Pro on 03/07/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit

class CountryNameCell: UITableViewCell {
    let titleLabel: UILabel = {
        UILabel().makeLabelItem(size: 16)
    }()

    let subTitleLabel: UILabel = {
        UILabel().makeLabelItem(size: 13)
    }()

    private let labelStackView: UIStackView = {
        let labelStackView = UIStackView()
        labelStackView.axis = NSLayoutConstraint.Axis.vertical
        labelStackView.distribution = UIStackView.Distribution.fillEqually
        return labelStackView
    }()

    private func labelStackViewConstraint() {
        self.labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            labelStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(self.labelStackView)
        self.labelStackViewConstraint()
        self.labelStackView.addArrangedSubview(self.titleLabel)
        self.labelStackView.addArrangedSubview(self.subTitleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UILabel {
    func makeLabelItem(size: CGFloat) -> UILabel {
        let makeLabel = UILabel()
        makeLabel.font = UIFont.systemFont(ofSize: size)
        return makeLabel
    }
}
