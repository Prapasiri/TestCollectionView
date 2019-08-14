//
//  Beer.swift
//  TestCollectionView
//
//  Created by Prapasiri Lertkriangkraiying on 14/8/2562 BE.
//  Copyright © 2562 Prapasiri Lertkriangkraiying. All rights reserved.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name: String
    let description: String
    let imageURL: String
    let abv: Float
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
        case abv
    }
}
