//
//  FortuneViewController.swift
//  Original_day1
//
//  Created by Koutaro Matsushita on 2021/08/30.
//

import UIKit
import AVFoundation
import Lottie

class FortuneViewController: UIViewController {
        
    @IBOutlet var userLabel:UILabel!
    
    var animationView = AnimationView()
    var seAudioPlayer: AVAudioPlayer?
    var stackV: UIStackView = UIStackView()
    var buttonArray: [UIButton] = []
    var stkArray: [UIStackView] = []
    let mainView: UIView = UIView()
    
    var dobon:Int!
    var userArray = [String]()
    var count = 0
    var index = 1
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
        addAnimationViewBomb()
        userLabel.text = userArray[count % userArray.count] + "の番"
    }
    
    @objc func makeButtons(){
        
        stackV.axis = .vertical
        stackV.alignment = .fill
        stackV.distribution = .fillEqually
        stackV.spacing = 4
        stackV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackV)
        stackV.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackV.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        stackV.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
       // stackV.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
     //   stackV.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
       // stackV.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.3).isActive = true
        //stackV.heightAnchor.constraint(equalTo: stackV.widthAnchor, multiplier: 1).isActive = true
        let bottom = stackV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        NSLayoutConstraint.activate([bottom])
        
        for _ in 0 ..< 2 {
            let stackH:UIStackView = UIStackView()
            stackH.axis = .horizontal
            stackH.alignment = .fill
            
            stackH.distribution = .fillEqually
            stkArray.append(stackH)
        }
        
        for i in 0 ..< 2 {
            stackV.addArrangedSubview(stkArray[i])
        }
        
        
        for _ in 0..<2*X{
            let btn: UIButton = UIButton(type: .custom)
            btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 100).isActive = true
            btn.tag = index
            index += 1
            btn.setImage(image, for: .normal)
            btn.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            buttonArray.append(btn)
        }
        
        let x =  2 * X
    
        for i in 0..<x{
            if X == 2{
                switch i {
                    case 0..<2:
                        stkArray[0].addArrangedSubview(buttonArray[i] as UIView)
                    case 2...4:
                        stkArray[1].addArrangedSubview(buttonArray[i] as UIView)
                    default:
                        return
                }
            }else if X == 3{
                switch i {
                    case 0..<3:
                        stkArray[0].addArrangedSubview(buttonArray[i] as UIView)
                    case 3...6:
                        stkArray[1].addArrangedSubview(buttonArray[i] as UIView)
                    default:
                        return
                }
            }else if X == 4{
                switch i {
                    case 0..<4:
                        stkArray[0].addArrangedSubview(buttonArray[i] as UIView)
                    case 4...8:
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
        
        playSE(fileName: "denden")
        Thread.sleep(forTimeInterval: 3)
        
        if sender.tag == dobon{
            playSE(fileName: "explode")
            self.animationView.removeFromSuperview()
            addAnimationViewExplode()
            count -= 1
            for button in buttonArray{
                button.isEnabled = false
            }
        }else{
            playSE(fileName: "seikai")
        }
        userLabel.text = userArray[count % userArray.count] + "の番"
    }
    
    @objc func rand(){
        if userArray.count == 2{
            dobon = Int.random(in: 1..<5)
        }else if userArray.count == 3{
            dobon = Int.random(in: 1..<7)
        }else if  userArray.count == 4{
            dobon = Int.random(in: 1..<9)
        }
    }

    @IBAction func reset(){
        count = 0
        index = 1
        rand()
        for button in buttonArray{
            button.isEnabled = true
        }
        userLabel.text = userArray[count % userArray.count] + "の番"
        self.animationView.removeFromSuperview()
        addAnimationViewBomb()
        
    }
    
    
    func playSE(fileName: String) {
        
        // サウンドの初期化
        guard let soundFilePath = Bundle.main.path(forResource: fileName, ofType: "mp3") else {
            
            assert(false, "ファイル名が間違っているので、読み込めません")
        }
        let fileURL = URL(fileURLWithPath: soundFilePath)
        
        do {
            seAudioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            seAudioPlayer?.prepareToPlay()
            seAudioPlayer?.play()
        } catch let error {
            assert(false, "サウンドの設定中にエラーが発生しました (\(error.localizedDescription))")
        }
    }
    
    func addAnimationViewBomb() {

            //アニメーションファイルの指定
            animationView = AnimationView(name: "3145-bomb")

            //アニメーションの位置指定（画面中央）
            animationView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 400)

            //アニメーションのアスペクト比を指定＆ループで開始
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()

            //ViewControllerに配置
            view.addSubview(animationView)
        }
    
    func addAnimationViewExplode() {

            //アニメーションファイルの指定
            animationView = AnimationView(name: "16871-boom-trah")

            //アニメーションの位置指定（画面中央）
            animationView.frame = CGRect(x: 0, y: 150, width: view.frame.size.width, height: 350)

            //アニメーションのアスペクト比を指定＆ループで開始
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()

            //ViewControllerに配置
            view.addSubview(animationView)
        }
}
