//
//  FortuneViewController.swift
//  Original_day1
//
//  Created by Koutaro Matsushita on 2021/08/30.
//

import UIKit

class FortuneViewController: UIViewController {
        
    @IBOutlet var bombImageView:UIImageView!
    @IBOutlet var userLabel:UILabel!
    
    var stackV: UIStackView = UIStackView()
    var buttonArray: [UIButton] = []
    var stkArray: [UIStackView] = []
    let mainView: UIView = UIView()
    
    var dobon:Int!
    var userArray = [String]()
    var count = 0
    var index = 0
    let image = UIImage(named: "1061309")
    var X:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if userArray.count == 2{
            X = 2
        }else if userArray.count == 3{
            X = 3
        }else if  userArray.count == 4{
            X = 4
        }
        rand()
        makeButtons()
        userLabel.text = userArray[count % userArray.count] + "の番"
    }
    
    @objc func makeButtons(){
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        mainView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
       // mainView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        //mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
   //     mainView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1.0).isActive = true
        let leftConstraint = NSLayoutConstraint.init(item: mainView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 15.0)
        leftConstraint.isActive = true
        let rightConstraint = NSLayoutConstraint.init(item: mainView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 15.0)
        rightConstraint.isActive = true
        let bottomConstraint = NSLayoutConstraint.init(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 100.0)
        bottomConstraint.isActive = true
        mainView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1.0).isActive = true
        stackV.axis = .vertical
        stackV.alignment = .fill
        stackV.distribution = .equalSpacing
        stackV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackV)
      //  stackV.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        stackV.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        stackV.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.9).isActive = true
        stackV.heightAnchor.constraint(equalTo: stackV.widthAnchor, multiplier: 0.1).isActive = true
        
        for _ in 0 ..< 2 {
            let stackH:UIStackView = UIStackView()
            stackH.axis = .horizontal
            stackH.alignment = .fill
            stackH.distribution = .equalSpacing
            stkArray.append(stackH)
        }
        
        for i in 0 ..< 2 {
            stackV.addArrangedSubview(stkArray[i])
        }
        
        
        for _ in 0..<2*X{
            let btn: UIButton = UIButton(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            btn.tag = index
            index += 1
            btn.setImage(image, for: .normal)
            btn.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            buttonArray.append(btn)
        }
        
        for i in 0..<2*X{
            if X == 2{
                switch i {
                    case 0..<2:
                     stkArray[0].addArrangedSubview(buttonArray[i] as UIView)
                    case 2..<4:
                        stkArray[1].addArrangedSubview(buttonArray[i] as UIView)
                    default:
                        return
                }
            }else if X == 3{
                switch i {
                    case 0..<3:
                        stkArray[0].addArrangedSubview(buttonArray[i] as UIView)
                    case 3..<6:
                        stkArray[1].addArrangedSubview(buttonArray[i] as UIView)
                    default:
                        return
                }
            }else if X == 4{
                switch i {
                    case 0..<4:
                        stkArray[0].addArrangedSubview(buttonArray[i] as UIView)
                    case 4..<8:
                        stkArray[1].addArrangedSubview(buttonArray[i] as UIView)
                    default:
                        return
                }
            }
        }
    }
    
    @objc func deleteButtons(){
        let views = self.view.subviews
        for myView in views {
            print("View:\(myView.description)")
            if myView.isKind(of:UIButton.self) {
                view.subviews.forEach { subview in
                    subview.removeFromSuperview()
                }
            }
        }
       
    }
    
    @objc func buttonTapped(sender: UIButton) {
        sender.isEnabled = false
        count += 1
        if sender.tag == dobon{
            bombImageView.image = UIImage(named:"1537118")
            count -= 1
            for button in buttonArray{
                button.isEnabled = false
            }
        }
        userLabel.text = userArray[count % userArray.count] + "の番"
    }
    
    @objc func rand(){
        if userArray.count == 2{
            dobon = Int.random(in: 0..<4)
        }else if userArray.count == 3{
            dobon = Int.random(in: 0..<6)
        }else if  userArray.count == 4{
            dobon = Int.random(in: 0..<8)
        }
    }

    @IBAction func reset(){
        count = 0
        index = 0
        rand()
        for button in buttonArray{
            button.isEnabled = true
        }
        bombImageView.image = UIImage(named:"other_bomb01_01")
        userLabel.text = userArray[count % userArray.count] + "の番"
    }
    
    @IBAction func back(){
      //  deleteButtons()
    }
    
}
