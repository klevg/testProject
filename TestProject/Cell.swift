//
//  Cell.swift
//  TestProject
//
//  Created by Евгений Клебан on 1/13/19.
//  Copyright © 2019 Евгений Клебан. All rights reserved.
//
import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: Item! {
        didSet {
            titleLabel.text = item.title
            descriptionLabel.text = item.description
        }
    }
}
