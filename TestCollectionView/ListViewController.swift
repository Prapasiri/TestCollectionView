//
//  ViewController.swift
//  TestCollectionView
//
//  Created by Prapasiri Lertkriangkraiying on 14/8/2562 BE.
//  Copyright © 2562 Prapasiri Lertkriangkraiying. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var beers: [Beer] = []  // initial item as empty array so it can count element at first is 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // After create BeerCollectionViewCell.xib let ListViewController know it by register
        let bundle = Bundle(for: BeerCollectionViewCell.self)
        let nib = UINib(nibName: "BeerCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: "BeerCollectionViewCell")
        
        // Do any additional setup after loading the view.
        APIManager().getBeers(urlString: "https://api.punkapi.com/v2/beers") { [weak self] (beers) in
//            DispatchQueue.main.sync {
//                guard let beers = beers else {
//                    return
//                }
//                print(beers)
//            }
            self?.beers = beers
            DispatchQueue.main.sync {
                self?.collectionView.reloadData()
            }
        }
    }

//    override func viewWillAppear(_ animated: Bool) {
//        // before show
//        super.viewWillAppear(animated)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        // after show
//        super.viewDidAppear(animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        // before go out
//        super.viewWillDisappear(animated)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        // after go out
//        super.viewDidDisappear(animated)
//    }

}

// click on collectionView and drag dataSource and delegate to view controller of that page

// use protocol by using extension and then click fix
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // numberOfItemsInSection is the number that will show
//        return item?.count? // if not initial as []
        
        return beers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCollectionViewCell", for: indexPath) as? BeerCollectionViewCell
            else{
            return UICollectionViewCell()
        }
        let beer = beers[indexPath.row]
        cell.setUpUI(beer: beer)
//        return UICollectionViewCell()
        return cell
    }
    
    
}

extension ListViewController: UICollectionViewDelegate {
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 321, height: 400.0)
    }
}
