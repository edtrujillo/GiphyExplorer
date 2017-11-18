//
//  ViewController.swift
//  GiphyExplorer
//
//  Created by Edmund Trujillo on 11/17/17.
//  Copyright © 2017 Edmund Trujillo. All rights reserved.
//

import UIKit

class GiphyMainViewController: UIViewController, UISearchBarDelegate {
    
    // since we are a container for the collection view ... keep a reference
    // to the collection vc so that we can hook up the searchbar to the
    // collection view for redraw events.  This is a weak reference as we know
    // that we already have a strong reference through interface builder
    weak var collectionVC : GiphyExplorerCollectionViewController?
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        // start off with the trending gifs rather than an empty screen
        fetchTrendingGifs { (gifs) in
            self.reloadCollectionView(gifs: gifs)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        collectionVC = (segue.destination as? GiphyExplorerCollectionViewController)
    }
    
    // shared function to dismiss keyboard, set the gifs on our collection vc and
    // then redraw the collection view cells
    private func reloadCollectionView(gifs : [Gif]) {
        searchBar.resignFirstResponder()
        self.collectionVC?.gifs = gifs
        self.collectionVC?.collectionView?.reloadData()
    }
}

// MARK: UISearchBarDelegate methods

extension GiphyMainViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // non-empty search text from search bar ... fetch the searched gifs
            if searchText.count > 0 {
                fetchSearchedGifs(searchText, { (gifs) in
                    self.reloadCollectionView(gifs: gifs)
                })
            } else {
                // user didn't put anything in ... revert to the trending gifs
                fetchTrendingGifs { (gifs) in
                    self.reloadCollectionView(gifs: gifs)
                }
            }
        }
    }
}

