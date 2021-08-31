//
//  ViewController.swift
//  Original_day1
//
//  Created by Koutaro Matsushita on 2021/08/30.
//

import UIKit

class ViewController: UIViewController {

    var user1:String?
    var user2:String?
    var user3:String?
    var user4:String?
    var users = [String]()
    var userArray = [String]()
    
    @IBOutlet var confirmButton: UIButton!
        
        
    override func viewDidLoad() {
            super.viewDidLoad()
    }
        
        
    @IBAction func user1Changed(_ sender: UITextField) {
            self.user1 = sender.text
            self.validate()
    }
        
    @IBAction func user2Changed(_ sender: UITextField) {
            self.user2 = sender.text
            self.validate()
    }
    
    @IBAction func user3Changed(_ sender: UITextField) {
            self.user3 = sender.text
            self.validate()
    }
    
    @IBAction func user4Changed(_ sender: UITextField) {
            self.user4 = sender.text
            self.validate()
    }
        
    @objc func validate() {
        let u1 = self.user1
        let u2 = self.user2
        
    
        if u1?.count == 0 || u2?.count == 0 || u1 == nil || u2 == nil{
            self.confirmButton.isEnabled = false
        }else{
            self.confirmButton.isEnabled = true
        }

    }
    
    @IBAction func confirm(){
        users.append(user1!)
        users.append(user2!)
        users.append(user3!)
        users.append(user4!)
        userArray = users.filter{!$0.isEmpty}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let FortuneViewController: FortuneViewController = segue.destination as! FortuneViewController
        FortuneViewController.userArray = self.userArray
    }

    @IBAction func unwindToViewController(segue: UIStoryboardSegue){
    
    }

}

