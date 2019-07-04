//
//  Data.swift
//  UISearchBarExample
//
//  Created by Meo MacBook Pro on 03/07/2019.
//  Copyright © 2019 Meo MacBook Pro. All rights reserved.
//

import UIKit

let countryData = loadData()

private func loadData() -> [Country] {
    let jsonDecoder = JSONDecoder()
    if let dataAsset = NSDataAsset(name: "Data") {
        do {
            let country = try jsonDecoder.decode([Country].self, from: dataAsset.data)
            return country
        } catch {
            print(error.localizedDescription)
        }
    }

    return [Country]()
}
