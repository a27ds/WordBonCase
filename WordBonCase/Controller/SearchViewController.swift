//
//  SearchViewController.swift
//  WordBonCase
//
//  Created by a27 on 2019-01-16.
//  Copyright © 2019 a27. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var words: [String] = []
    var filtredWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        filtredWords = words
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell")!
        let text = filtredWords[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //This line of code i didn't write, i understand in someway it's meaning but i think i need an explanation from you. it's so cramped up! Did a own filter function in the end (I don't use it)
        filtredWords = searchText.isEmpty ? words : words.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func filterContentForSearchText(searchText: String) {
        filtredWords = words.filter { item in
            return item.lowercased().contains(searchText.lowercased())
        }
    }
}
