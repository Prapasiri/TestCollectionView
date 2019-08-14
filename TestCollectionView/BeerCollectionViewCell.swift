//
//  BeerCollectionViewCell.swift
//  TestCollectionView
//
//  Created by Prapasiri Lertkriangkraiying on 14/8/2562 BE.
//  Copyright © 2562 Prapasiri Lertkriangkraiying. All rights reserved.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var abvLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpUI(beer: Beer) {
        nameLabel.text = beer.name
        descriptionLabel.text = beer.description
        abvLabel.text = "\(beer.abv)"
    }
}
