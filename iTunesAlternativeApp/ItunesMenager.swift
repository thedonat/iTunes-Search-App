//
//  itunesMenager.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 23.01.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.


import Foundation
import UIKit

protocol updateUIDelegate: class {
    func updateUI(modal : ItunesData)
    func didFailWithError(error: Error?)
}

struct itunesMenager {
            
    let baseURL = "https://itunes.apple.com/search?"
    weak var delegate : updateUIDelegate?

    func fetchSearch(term: String)  {
        let URLString = "\(baseURL)term=\(term)"
        print(URLString)
        performRequest(with: URLString)
    }
    
    func fetchType(term: String , media: String) {
        let URLString = "\(baseURL)term=\(term)&media=\(media)"
        print(URLString)
        performRequest(with: URLString)
    }
    
    func performRequest(with urlString: String) {
        //1,Create a URL
        if let url = URL(string: urlString) {
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            //3.Give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    
                 if let data = self.parseJSON(safeData) {
                     self.delegate?.updateUI(modal: data)
                     }
                }
            }
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ idata : Data) -> ItunesData? {
        do {
            let decodedData = try JSONDecoder().decode(ItunesData.self, from: idata)
            return decodedData
        }
        catch {
            self.delegate?.didFailWithError(error: error)
            print("ERROR")
            return nil
        }
    }
}
