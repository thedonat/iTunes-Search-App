//
//  DetailsViewController.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 25.01.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    var getName = String()
    var getTrackName = String()
    var getArtworkUrl = String()
    let tableViewCell = TableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false

        artistNameLabel.text = getName
        trackNameLabel.text = getTrackName
        setImage(from: getArtworkUrl)
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.artworkImageView.image = image
            }
        }
    }
}
