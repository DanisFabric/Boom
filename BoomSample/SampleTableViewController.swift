//
//  ViewController.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import UIKit
import Boom

class SampleTableViewController: UITableViewController {
    @IBOutlet weak var toastCustomCell: UITableViewCell!
    @IBOutlet weak var toastSuccessCell: UITableViewCell!
    @IBOutlet weak var toastInfoCell: UITableViewCell!
    @IBOutlet weak var toastWarningCell: UITableViewCell!
    
    
    @IBOutlet weak var snackCustomCell: UITableViewCell!
    @IBOutlet weak var snackSuccessCell: UITableViewCell!
    @IBOutlet weak var snackInfoCell: UITableViewCell!
    @IBOutlet weak var snackWarningCell: UITableViewCell!
    
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        switch cell {
        case toastCustomCell:
            boom.show(toast: .custom(.color(UIColor.purple), .custom(UIImage(named: "like")!), .light), title: "I am Custom Toast", duration: 2)

        case toastSuccessCell:
            boom.show(toast: .success, title: "I am Toast")

        case toastInfoCell:
            boom.show(toast: .info, title: "I am Toast")

        case toastWarningCell:
            boom.show(toast: .warning, title: "I am Toast")

        case snackCustomCell:
            boom.show(snackBar: .custom(.blur(.dark), .light), title: "I am Custom SnackBar", action: Action(title: "Touch Me", handler: {
                print("Did Touch")
            }))
        case snackSuccessCell:
            boom.show(snackBar: .success, title: "I am SnackBar", action: Action(title: "Touch me", handler: {
                
            }))
        case snackInfoCell:
            boom.show(snackBar: .info, title: "I am SnackBar", action: Action(title: "Touch me", handler: {
                
            }))
        case snackWarningCell:
            boom.show(snackBar: .warning, title: "I am SnackBar", action: Action(title: "Touch me", handler: {
                
            }))
        default:
            break
        }
        
    }
}

