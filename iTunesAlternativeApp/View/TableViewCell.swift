//
//  TableViewCell.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 24.01.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.origin.x += 10
            frame.size.height -= 15
            frame.size.width -= 2 * 10
            super.frame = frame
        }
    }
    
    func setImage(from photoUrl: String) {
        let url = URL(string: photoUrl)
        artworkImage.kf.setImage(with: url)
    }
    
    func setView(collectionNameStr: String, name: String, imageURL: String) {
        collectionName.text = collectionNameStr
        nameLabel.text = name
        setImage(from: imageURL)
    }
}
