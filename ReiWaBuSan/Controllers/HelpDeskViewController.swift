//
//  HelpDeskViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/06.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase


class HelpDeskViewController: UIViewController {
    var messages: [Message] = []
    let db = Firestore.firestore()
    @IBOutlet weak var messageTable: UITableView!
  
    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTable.dataSource = self
        navigationItem.hidesBackButton = true
        messageTable.register(UINib(nibName: U.messageCellnibName, bundle: nil), forCellReuseIdentifier: U.cellIdentifier)
        loadMessage()
    }
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        messageTextField.endEditing(true)
        if let userMail = Auth.auth().currentUser?.email {
            db.collection(userMail).getDocuments { (querySnapShot, error) in
                if let err = error {
                    print("There was something wrong: \(err)")
                } else {
                    let nickName = querySnapShot?.documents[0].data()[U.nickName]//ユーザー名を抽出
                    if let messageBody = self.messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
                        self.db.collection(M.messageCollection).addDocument(data: [M.messageSender: messageSender, M.messageBody: messageBody, M.messageDate: Date().timeIntervalSince1970, M.messageNiceName: nickName as Any]) { (error) in
                            if let e = error {
                                print("something wrong with \(e)")
                            } else {
                                print("success")
                                self.messageTextField.text = ""
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    func loadMessage(){
        if let userMail = Auth.auth().currentUser?.email {
            db.collection(M.messageCollection).order(by: M.messageDate).addSnapshotListener { (querySnapShot, error) in
                
                self.messages = []
                
                if let e = error {
                    print("there was something wrong with \(e)")
                } else {
                    if let documents = querySnapShot?.documents {
                        for doc in documents {
                            let data = doc.data()
                           if let sender = data[M.messageSender] as? String
                            ,let body = data[M.messageBody] as? String,let nickName = data[M.messageNiceName] as? String
                            {
                            let newMessage = Message(sender: sender, body: body, nickName: nickName)
                            self.messages.append(newMessage)
                            self.messageTable.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.messageTable.scrollToRow(at: indexPath, at: .top, animated: true)//最下部にスクロールする
                            
                            }
                        }
                    }
                }
            }
        }
    }
}

//MARK: - UITableView

extension HelpDeskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = messageTable.dequeueReusableCell(withIdentifier: U.cellIdentifier, for: indexPath) as! MessageCell
        cell.MessageLabel.text = messages[indexPath.row].body
        cell.NickNameLabel.text = messages[indexPath.row].nickName
        cell.HelpDeskNameLabel.text = messages[indexPath.row].nickName
        cell.RightIconView?.image = UIImage(systemName: messages[indexPath.row].imageId)
        cell.LeftIconView.image = UIImage(systemName: messages[indexPath.row].imageId)
        //発信者がログインユーザーの場合
        if message.sender == Auth.auth().currentUser?.email {
           //左辺のアイコンを隠し、右辺のアイコンを表示
            cell.LeftIconView.isHidden = true
            cell.HelpDeskNameLabel.isHidden = true
            cell.RightIconView.isHidden = false
            cell.NickNameLabel.isHidden = false
            cell.MessageBubble.backgroundColor = #colorLiteral(red: 0.838580259, green: 0.6743927815, blue: 0.9686274529, alpha: 1)
            cell.MessageLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        } //発信者がカレントユーザーじゃない場合
        else {
            cell.LeftIconView.isHidden = false
            cell.HelpDeskNameLabel.isHidden = false
            cell.RightIconView.isHidden = true
            cell.NickNameLabel.isHidden = true
            cell.MessageBubble.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            cell.MessageLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        
        return cell
    }
}

// MARK: - UITextField
extension HelpDeskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        messageTextField.text = ""
    }
    
    
}
