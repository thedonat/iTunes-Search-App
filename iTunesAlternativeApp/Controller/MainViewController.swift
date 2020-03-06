//
//  MainViewController.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 21.01.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation
import UIKit

class SearchViewConroller : UITableViewController {
    
    var itunesMenager = ItunesMenager()
    
    override func viewDidLoad() {
        itunesMenager.fetchAlbum(singerName: "musicVideo")
    }
}
