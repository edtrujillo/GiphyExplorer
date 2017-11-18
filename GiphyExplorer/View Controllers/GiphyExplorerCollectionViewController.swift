//
//  GiphyExplorerCollectionViewController.swift
//  GiphyExplorer
//
//  Created by Edmund Trujillo on 11/17/17.
//  Copyright © 2017 Edmund Trujillo. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "GiphyCollectionViewCell"
private let segueToDetails = "SegueToDetails"

class GiphyExplorerCollectionViewController: UICollectionViewController {
    
    var gifs = [Gif]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self;
        
        // try to fit a pleasing set of collection view cells dependent on the device
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let screenSize = UIScreen.main.bounds
        layout.itemSize = CGSize(width: screenSize.width / 4, height: screenSize.width / 4)
        
        collectionView?.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue to the details screen with the details passed to the new detailsVC
        if segue.identifier == segueToDetails {
            guard let indexPaths = self.collectionView?.indexPathsForSelectedItems else { return }
            let giphyDetailsVC = segue.destination as? GiphyDetailsTableViewController
            let row = indexPaths[0].row
            giphyDetailsVC?.gif = gifs[row]
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GiphyExplorerCollectionViewCell
        
        cell.activityIndicator.startAnimating()
        let gif = gifs[indexPath.row]
        let urlStr = gif.imageUrl
        
        // Feed into Kingfisher for async update
        let imageUrl = URL(string: urlStr)
        cell.imageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            if imageUrl == url {
                cell.imageView.image = image
                cell.activityIndicator.stopAnimating()
            }
        }
        
        return cell
    }
}
