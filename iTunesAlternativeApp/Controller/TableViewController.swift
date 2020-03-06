//
//  TableViewController.swift
//  iTunesAlternativeApp
//
//  Created by Burak Donat on 24.01.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var errorLabel: UILabel!
    
    var menager = itunesMenager()
    var data : [results] = []
    var type : String = ""
    var selectedResultsId : [Int] = []
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedIds = defaults.value(forKey: "selectedIds") as? [Int] { //retrieve from userdefaults
            selectedResultsId = selectedIds
        }

        tableView.dataSource = self
        tableView.delegate = self
        registerTable()
        menager.delegate = self
        searchBar.delegate = self
        filterTableView(index: searchBar.selectedScopeButtonIndex)
        searchBar.searchTextField.backgroundColor = UIColor.white
        navigationItem.hidesBackButton = true
        
        
        filterTableView(index: 0)
        menager.fetchType(term: type , media: type)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        defaults.set(selectedResultsId, forKey: "selectedIds") //save to userdefaut
    }
    
    func registerTable() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func filterTableView(index : Int) {
        switch index {
        case 0:
            self.type = "all"
        case 1:
            self.type = "music"
        case 2:
            self.type = "movie"
        case 3:
            self.type = "podcast"
        default: break
        }
    }
}

extension TableViewController : updateUIDelegate {
    func didFailWithError(error: Error?) {
        DispatchQueue.main.async {
            self.errorLabel.text = "There is no result found \(error?.localizedDescription ?? "")"
            self.tableView.isHidden = true
            self.errorLabel.isHidden = false
        }
    }
    
    func updateUI(modal: ItunesData) {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.errorLabel.isHidden = true
        }
        
        if modal.results.count == 0 {
            didFailWithError(error: nil)
        } else {
            self.data = modal.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension TableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.setView(collectionNameStr: data[indexPath.row].trackName,
        name: data[indexPath.row].artistName,
        imageURL: data[indexPath.row].artworkUrl100)
        
        
        if selectedResultsId.contains(data[indexPath.row].trackId) {
            cell.view.backgroundColor = .systemPink
            cell.contentView.backgroundColor = .systemPink
        } else {
            cell.view.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
        }
        
       
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        
        
        return cell
    }
}

extension TableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedId = data[indexPath.row].trackId
        if !selectedResultsId.contains(selectedId) {
            selectedResultsId.append(selectedId)
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.contentView.backgroundColor = .systemPink
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
    
//          detailVC.dataDetails = data
        detailVC.getName = data[indexPath.row].artistName
        detailVC.getTrackName = data[indexPath.row].trackName
        detailVC.getArtworkUrl = data[indexPath.row].artworkUrl100
        
        self.navigationController?.pushViewController(detailVC , animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension TableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = (searchBar.text)  {
            let formattedString = searchText.replacingOccurrences(of: " ", with: "")
            menager.fetchType(term: formattedString , media: type)
        }
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterTableView(index: selectedScope)
        let formattedString = searchBar.text?.replacingOccurrences(of: " ", with: "")
        if let searchText = (formattedString) {
            if searchText != "" {
                menager.fetchType(term: searchText , media: type)
            } else {
                menager.fetchType(term: type , media: type)
            }
        } else {
            menager.fetchType(term: type , media: type)
        }
    }
}
