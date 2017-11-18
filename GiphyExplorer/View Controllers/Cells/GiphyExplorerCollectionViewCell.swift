//
//  GiphyExplorerCollectionViewCell.swift
//  GiphyExplorer
//
//  Created by Edmund Trujillo on 11/17/17.
//  Copyright © 2017 Edmund Trujillo. All rights reserved.
//

import UIKit

class GiphyExplorerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        self.dropShadow()
    }
}

// add a nice drop shadow on the collectionview cells
extension UICollectionViewCell {
     func dropShadow() {
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        
        // try to give different devices similar looks
        let scale = UIScreen.main.scale / 0.5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5 * scale, height: 3.0 * scale)
        self.layer.shadowRadius = 3.0 * scale
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
