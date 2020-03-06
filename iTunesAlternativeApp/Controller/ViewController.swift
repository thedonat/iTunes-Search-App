//
//  ViewController.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 21.01.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenAnimation()
    }
    
    func mainScreenAnimation(){
        mainLabel.text = ""
        var charIndex = 0.0
        let titleText = "iTunes🎵"
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.mainLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
}
