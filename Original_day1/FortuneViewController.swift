//
//  FortuneViewController.swift
//  Original_day1
//
//  Created by Koutaro Matsushita on 2021/08/30.
//

import UIKit

class FortuneViewController: UIViewController {
    
    @IBOutlet var bombImageView:UIImageView!
    @IBOutlet var resultLabel:UILabel!
    @IBOutlet var userLabel:UILabel!
    @IBOutlet var select1:UIButton!
    @IBOutlet var select2:UIButton!
    @IBOutlet var select3:UIButton!
    @IBOutlet var select4:UIButton!
    @IBOutlet var select5:UIButton!
    @IBOutlet var select6:UIButton!
    
    
    var array = [0,0,0,0,0,1]
    var userArray = [String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        array.shuffle()
        userArray.shuffle()
        userLabel.text = userArray[count] + "の番"
    }

    @objc func check(index:Int){
        count += 1
        if array[index] == 1{
            resultLabel.text = "Bomb!"
            resultLabel.textColor = UIColor.red
            select1.isEnabled = false
            select2.isEnabled = false
            select3.isEnabled = false
            select4.isEnabled = false
            select5.isEnabled = false
            select6.isEnabled = false
            bombImageView.image = UIImage(named:"1537118")
            count -= 1
        }else{
//            resultLabel.text = "セーフ"
            resultLabel.textColor = UIColor.green
        }
        userLabel.text = userArray[count % userArray.count] + "の番"
    }
    
    @IBAction func one(){
        select1.isEnabled = false
        check(index: 0)
        
    }
    
    @IBAction func two(){
        select2.isEnabled = false
        check(index: 1)
    }
    
    @IBAction func three(){
        select3.isEnabled = false
        check(index: 2)
    }
    
    @IBAction func four(){
        select4.isEnabled = false
        check(index: 3)
    }

    @IBAction func five(){
        select5.isEnabled = false
        check(index: 4)
    }
    
    @IBAction func six(){
        select6.isEnabled = false
        check(index: 5)
    }
    
//    @IBAction func reset(){
//        select1.isEnabled = true
//        select2.isEnabled = true
//        select3.isEnabled = true
//        select4.isEnabled = true
//        select5.isEnabled = true
//        select6.isEnabled = true
//        resultLabel.text = ""
//        array.shuffle()
//    }
    
}
