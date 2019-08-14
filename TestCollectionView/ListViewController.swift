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
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var beers: [Beer] = []  // initial item as empty array so it can count element at first is 0
    var page = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // After create BeerCollectionViewCell.xib let ListViewController know it by register
        let bundle = Bundle(for: BeerCollectionViewCell.self)
        let nib = UINib(nibName: "BeerCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: "BeerCollectionViewCell")
        // call function that call API with parameter was page
        getBeerAPI()
        
        // Do any additional setup after loading the view.
//        APIManager().getBeers(urlString: "https://api.punkapi.com/v2/beers") { [weak self] (beers) in
////            DispatchQueue.main.sync {
////                guard let beers = beers else {
////                    return
////                }
////                print(beers)
////            }
//            self?.beers = beers
//            DispatchQueue.main.sync {
//                self?.collectionView.reloadData()
//            }
//        }
    }
    
    func getBeerAPI(){
        // show loading
        isLoading = true
        loadingView.isHidden = false
        let apiManager = APIManager()
        APIManager().getBeers(urlString: "https://api.punkapi.com/v2/beers?page=\(page)") { [weak self] (beers) in
            
            self?.beers.append(contentsOf: beers)
//             sleep(3)
            DispatchQueue.main.sync {
                self?.isLoading = false
                self?.loadingView.isHidden = true   // hide loading after loadData
                self?.collectionView.reloadData()
                self?.page += 1
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == beers.count - 1 {
            getBeerAPI()
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromButtom = scrollView.contentSize.height - contentYoffset
        if distanceFromButtom < height {
            if !isLoading{
                getBeerAPI()
            }
        }
    }
    
}

extension ListViewController: UICollectionViewDelegate {
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 321, height: 400.0)
    }
}
