//
//  CartViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/11.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase

class CartViewController: UIViewController {
    var cartDataArray:[CartData] = []
    let db = Firestore.firestore()
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.dataSource = self
        cartTableView.register(UINib(nibName: C.cartCellnibName, bundle: nil), forCellReuseIdentifier: C.cartCellIdetifier)
        loadCartData()
       
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        loadCartData()
    }
    
    func loadCartData(){
        if let userMail = Auth.auth().currentUser?.email {
            db.collection(C.cartItemCollection + userMail).addSnapshotListener { (querySnapShot, err) in
                self.cartDataArray = []
                if let err = err {
                    print("something wrong with \(err)")
                } else {
                    if let documents = querySnapShot?.documents {
                        for doc in documents {
                            let data = doc.data()
                            if let itemName = data[C.cartItemName] as? String, let itemNum = data[C.cartItemNumber] as? String, let itemNo = data[C.cartItemNO] as? String, let description = data[C.cartItemDescription] as? String {
                                let newData = CartData(itemName: itemName, itemNum: itemNum, itemNO: itemNo, itemDescription: description)
                                self.cartDataArray.append(newData)
                                self.cartTableView.reloadData()
                                if self.cartDataArray.count == 0 {
                                    self.tabBarItem.badgeValue = nil
                                } else {
                                    self.tabBarItem.badgeValue = "\(self.cartDataArray.count)"
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
}


//MARK: - Table
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartData = cartDataArray[indexPath.row]
        let cell = cartTableView.dequeueReusableCell(withIdentifier: C.cartCellIdetifier, for: indexPath) as! CartItemCell
        cell.itemNameLabel.text = cartData.itemName
        cell.itemNOLabel.text = cartData.itemNO
        cell.numOfItemInCart.text = cartData.itemNum
        cell.itemDescriptionLabel.text = cartData.itemDescription
        return cell
    }
    
    
}
