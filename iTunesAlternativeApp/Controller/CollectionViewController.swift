//
//  CollectionViewController.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 23.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Gemini

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionView: GeminiCollectionView!
    var dataDetails = [results]()


    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataDetails)
        let width = (view.frame.width-20)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.gemini
            .scaleAnimation()
            .scale(0.75)
            .scaleEffect(.scaleUp)
        
    }
    
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.setImage(from: dataDetails[indexPath.row].artworkUrl100)
        self.collectionView.animateCell(cell)
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 12 * 3) / 3 //some width
        let height = width * 1.5 //ratio
        return CGSize(width: width, height: height)
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.artistNameLabel.text = dataDetails[indexPath.row].artistName
        self.trackNameLabel.text = dataDetails[indexPath.row].trackName
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.collectionView.animateVisibleCells()
//    }
}

