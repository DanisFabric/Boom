//
//  ViewController.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import UIKit
import Boom

class ViewController: UIViewController {
    
    
    var boom: Boom!
    
    var indexes = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        boom = Boom(base: self.navigationController!)
        boom = Boom(base: nil)
        boom.offset = UIOffset(horizontal: 0, vertical: 64)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func snakerCustom(_ sender: Any) {
        boom.show(snackBar: .custom(.blur(.dark), .light), title: "I am Custom SnackBar", action: Action(title: "Touch Me", handler: { 
            print("Did Touch")
        }))
    }
    @IBAction func snakerInfo(_ sender: Any) {
        boom.show(snackBar: .info, title: "I am SnackBar", action: Action(title: "Touch me", handler: {
            
        }))
    }
    @IBAction func snakerSucess(_ sender: Any) {
        boom.show(snackBar: .success, title: "I am SnackBar", action: Action(title: "Touch me", handler: {
            
        }))
    }
    @IBAction func snakerWarning(_ sender: Any) {
        boom.show(snackBar: .warning, title: "I am SnackBar", action: Action(title: "Touch me", handler: {
            
        }))
    }
    
    @IBAction func toastCustom(_ sender: Any) {
        boom.show(toast: .custom(.color(UIColor.purple), .custom(UIImage(named: "like")!), .light), title: "I am Custom Toast", duration: 2)
    }
    
    @IBAction func toastInfo(_ sender: Any) {
        boom.show(toast: .info, title: "I am Toast")

    }
    @IBAction func toastSucess(_ sender: Any) {
        boom.show(toast: .success, title: "I am Toast")

    }
    @IBAction func toastWarning(_ sender: Any) {
        boom.show(toast: .warning, title: "I am Toast")

    }
}

