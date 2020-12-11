//
//  MailBoxViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/10.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase

class MailBoxViewController: UIViewController {
    var mailArray:[MailData] = []
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var MailTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func loadData() {
        db.collection(Ma.mailCollection).getDocuments { (querySnapShop, err) in
            if let err = err {
                print("some thing wrong with \(err)")
                
            } 
        }
    }
}

//MARK: - TableViewDataSource
extension MailBoxViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return mailArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mail = mailArray[indexPath.row]
        let cell = MailTableView.dequeueReusableCell(withIdentifier: Ma.mailCellIdentifier, for: indexPath) as! MailCell
        cell.titleTextLabel.text = mail.title
        cell.ContentLabel.text = mail.content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MailContentView", sender: self)
        
            TempData.title = mailArray[indexPath.row].title
                TempData.content = mailArray[indexPath.row].content
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let MailContentVC = segue.destination as! MailContentViewController
    MailContentVC.titleLabel.text = TempData.title
    MailContentVC.contentTextView.text = TempData.content
    
      }
}

//MARK: - SearchBar
extension MailContentViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}
