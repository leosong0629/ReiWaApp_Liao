//
//  SearchViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/07.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {
    var itemArray: [Item] = []
    let db = Firestore.firestore()


    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: I.itemCellnibName, bundle: nil), forCellReuseIdentifier: I.itemCellIdentifier)
    }
    

}

//MARK: - UITable
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = searchTableView.dequeueReusableCell(withIdentifier: I.itemCellIdentifier, for: indexPath) as! ItemCell
        cell.ItemNameLabel.text = item.itemName
        cell.ItemDescriptionLabel.text = item.itemDescrption
        cell.itemNOLabel.text = item.itemNo
        cell.cartButton.isHidden = false
        return cell
    }
    
    
}

//MARK: - SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.itemArray = []
        self.searchTableView.reloadData()
        searchBar.scopeButtonTitles?[0] = "\(self.itemArray.count)件一致"
        if let text = searchBar.text {
            db.collection(I.itemCollection).whereField(I.itemName, isLessThanOrEqualTo: text).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Something wrong with \(err)")
                } else {
                    for doc in querySnapshot!.documents {
                        let data = doc.data()
                        if let name = data[I.itemName] as? String,let description = data[I.itemDescription] as? String, let itemNo = data[I.itemNO] as? String {
                            let newItem = Item(itemName: name, itemDescrption: description, itemNo: itemNo)
                            self.itemArray.append(newItem)
                            self.searchTableView.reloadData()
                            searchBar.scopeButtonTitles?[0] = "\(self.itemArray.count)件一致"
                            searchBar.text = ""
                            searchBar.endEditing(true)
                            
                        }
                    }
                }
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
}
