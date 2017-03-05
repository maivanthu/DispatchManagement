//
//  listCVTableViewController.swift
//  DispatchManagement
//
//  Created by VanThu on 27/02/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit
import Alamofire

class listCVTableViewController: UITableViewController {

    var listCV = [[String: AnyObject]]()
    let urlString = "https://masterdocs.herokuapp.com/api/document"
    
    var sovanbanArray = [String]()
    var loaivanbanArray = [String]()
    //var imgURLArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let url:String = "https://masterdocs.herokuapp.com/api/document"
        let urlRequest = URL(string: url)
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
        (data, response, error) in
            if(error != nil){
                print(error.debugDescription)
            }else{
                do{
                    self.listCV = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    
                        self.tableView.reloadData()
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }).resume()*/
        self.dowloadJsonwithURL()
        
    }
    
   
    func dowloadJsonwithURL(){
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                //print(jsonObj!.value(forKey: "msg"))
                
                if let dispatchArray = jsonObj!.value(forKey: "msg") as? NSArray {
                    for dispatch in dispatchArray{
                        if let dispatchDict = dispatch as? NSDictionary {
                            if let name = dispatchDict.value(forKey: "SoVanBan") {
                                self.sovanbanArray.append(name as! String)
                            }
                            if let name = dispatchDict.value(forKey: "LoaiVanBan") {
                                self.loaivanbanArray.append(name as! String)
                            }
                            //if let name = dispatchDict.value(forKey: "image") {
                              //  self.imgURLArray.append(name as! String)
                            //}
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listCV.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let item = self.listCV[indexPath.row]
        
        cell.textLabel?.text = item["SoVanBan"] as? String
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
