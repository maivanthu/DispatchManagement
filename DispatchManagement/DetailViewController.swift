//
//  DetailViewController.swift
//  MasterDocs
//
//  Created by VanThu on 05/03/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var sovanbanLabel: UILabel!
    @IBOutlet weak var loaivanbanLabel: UILabel!
    
    //data from previous controller
    var sovanbanString:String!
    var loaivanbanString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        self.sovanbanLabel.text = sovanbanString
        self.loaivanbanLabel.text = loaivanbanString
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
