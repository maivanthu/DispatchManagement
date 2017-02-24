//
//  ChitietViewController.swift
//  DispatchManagement
//
//  Created by VanThu on 22/02/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit

class ChitietViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var thamsotruyen: UserDefaults!
    
    @IBOutlet weak var mytable1: UITableView!

    
    var danhsachChiDao:[String] = ["A1", "A2", "A3", "A4", "A5"]
    var danhsachChuTri:[String] = ["B1", "B2", "B3", "B4", "B5"]
    var danhsachPhoiHop:[String] = ["C1", "C2", "C3", "C4", "C5"]
    var danhsachTheoDoi:[String] = ["D1", "D2", "D3", "D4", "D5"]
    var n:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       mytable1.dataSource = self
       mytable1.delegate = self
        
        thamsotruyen = UserDefaults()
        
        let chon:String = (thamsotruyen.object(forKey: "dong") as! NSString) as String
        n = Int(chon)!
        //print(String(n))
        // Do any additional setup after loading the view.
    
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if n == 0{
            return danhsachChiDao.count
        }
        else if n == 1{
            return danhsachChuTri.count
        }
        else if n == 2{
            return danhsachPhoiHop.count
        }
        else{
            return danhsachTheoDoi.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if n == 0{
            cell.textLabel?.text = danhsachChiDao[indexPath.row]
        }
        else if n == 1{
            cell.textLabel?.text = danhsachChuTri[indexPath.row]
        }
        else if n == 2{
            cell.textLabel?.text = danhsachPhoiHop[indexPath.row]
        }
        else{
            cell.textLabel?.text = danhsachTheoDoi[indexPath.row]
        }
        return cell
    }
    
  
   /* override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
