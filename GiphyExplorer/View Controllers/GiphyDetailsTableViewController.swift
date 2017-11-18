//
//  GiphyDetailsTableViewController.swift
//  GiphyExplorer
//
//  Created by Edmund Trujillo on 11/17/17.
//  Copyright © 2017 Edmund Trujillo. All rights reserved.
//

import UIKit

// This is a simple static tableview using dynamic font types
class GiphyDetailsTableViewController: UITableViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    
    var gif: Gif? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        let numFormatter = NumberFormatter()
        numFormatter.usesGroupingSeparator = true
        numFormatter.alwaysShowsDecimalSeparator = false
        numFormatter.groupingSize = 3
        numFormatter.groupingSeparator = ","
        
        if let title = gif?.title {
            if !title.isEmpty {
                titleLabel.text = title
            } else {
                titleLabel.text = NSLocalizedString("No title available", comment: "No titles are available")
            }
        }
        
        if let size = gif?.size {
            let sizeNumber = NSNumber(value: size)
            if let str = numFormatter.string(from: sizeNumber) {
                sizeLabel.text = NSLocalizedString("Size: \(str) bytes", comment: "size in bytes")
            }
        }
        
        if let height = gif?.height {
            heightLabel.text = NSLocalizedString("Height: \(height)", comment: "height")
        }
        
        if let width = gif?.width {
            widthLabel.text = NSLocalizedString("Width: \(width)", comment: "width")
        }
        
        if let imageUrl = gif?.imageUrl {
            urlLabel.text = NSLocalizedString("URL: " + imageUrl, comment: "url string")
        }
    
        if let rating = gif?.rating {
            ratingLabel.text = NSLocalizedString("Rating: " + rating.localizedUppercase, comment: "rating")
        }
        
        if let source = gif?.source {
            sourceLabel.text = NSLocalizedString("Source: " + source, comment: "source")
        }
        
        if let imageUrl = gif?.imageUrl {
            let url = URL(string: imageUrl)
            imageview.kf.setImage(with: url)
        }
    }
}
