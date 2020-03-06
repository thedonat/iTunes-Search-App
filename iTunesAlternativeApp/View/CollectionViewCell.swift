//
//  CollectionViewCell.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 23.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Gemini

class CollectionViewCell: GeminiCell {
    
    @IBOutlet weak var trackImage: UIImageView!
    
    func setImage(from photoUrl: String) {
        let url = URL(string: photoUrl)
        trackImage.kf.setImage(with: url)
    }
}
