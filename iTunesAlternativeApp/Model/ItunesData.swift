//
//  itunesData.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 21.01.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct ItunesData: Codable {
    let results: [results]
}

struct results: Codable {
    var artistName: String
    let trackName: String
    let artworkUrl100: String
    let trackId : Int
}
