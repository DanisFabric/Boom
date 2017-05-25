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
        
        boom = Boom(base: self.navigationController!)
        boom.offset = UIOffset(horizontal: 0, vertical: 64)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func snakerInfoDark(_ sender: Any) {
        boom.show(snackBar: .info, title: "I am SnackBar", action: Action(title: "Touch me", handler: {
            print("Did Touch")
        }))
    }
    @IBAction func snakerInfoLight(_ sender: Any) {
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
    
    @IBAction func toastInfoDark(_ sender: Any) {
        boom.show(toast: .info, title: "I am Toast")
    }
    
    @IBAction func toastInfoLight(_ sender: Any) {
        boom.show(toast: .info, title: "I am Toast")

    }
    @IBAction func toastSucess(_ sender: Any) {
        boom.show(toast: .success, title: "I am Toast")

    }
    @IBAction func toastWarning(_ sender: Any) {
        boom.show(toast: .warning, title: "I am Toast")

    }
}

