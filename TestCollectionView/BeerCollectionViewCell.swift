//
//  BeerCollectionViewCell.swift
//  TestCollectionView
//
//  Created by Prapasiri Lertkriangkraiying on 14/8/2562 BE.
//  Copyright © 2562 Prapasiri Lertkriangkraiying. All rights reserved.
//

import UIKit

// Dictionary [key: value]
var imageCashe: [String: UIImage] = [:] // global variable for using the same cashe

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
        abvLabel.text = "\(beer.abv)%"
        
        // check if it already have that image
        if let image = imageCashe[beer.imageURL] {
            beerImageView.image = image
        } else if let url = URL(string: beer.imageURL) {
            //if it not have that image in imageCashe, it will download image and keep in imageCashe
            // async -> create thread in background
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        imageCashe[beer.imageURL] = image    // keep image in imageCashe
                        DispatchQueue.main.sync {
                            self.beerImageView.image = image
                        }
                    }
                }
            }
        }
    }
}
