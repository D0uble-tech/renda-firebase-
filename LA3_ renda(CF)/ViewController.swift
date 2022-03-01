//
//  ViewController.swift
//  LA3_ renda(CF)
//
//  Created by Motonari Sakuma on 2022/02/28.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var tapButton: UIButton!
    
    var tapCount = 0
    
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tapButton.layer.cornerRadius = 100
        
        firestore.collection("count").document("share").addSnapshotListener { snapshot, error in
                    if error != nil {
                        print("エラーが発生しました")
                        return
                    }
                    let data = snapshot?.data()
                    if data == nil {
                        print("データがありません")
                        return
                    }
                    let count = data!["count"] as? Int
                    if count == nil {
                        print("countという対応する値がありません")
                        return
                    }
                    self.tapCount = count!
            self.countLabel.text = String(self.tapCount)
                }
        
    }
    
    @IBAction func tapTapButton() {
        tapCount = tapCount + 1
        countLabel.text = String(tapCount)
        firestore.collection("counts").document("share").setData(["count": tapCount])
        
    }
    

}

