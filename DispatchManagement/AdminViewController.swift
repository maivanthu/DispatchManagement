//
//  AdminViewController.swift
//  DispatchManagement
//
//  Created by VanThu on 22/02/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var mytableView: UITableView!
    var danhsachchon:[String]!
    var thamsotruyen: UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mytableView.delegate = self
        mytableView.dataSource = self
        
        danhsachchon = ["Chỉ đạo", "Chủ trì", "Phối hợp", "Theo dõi"]
        
        thamsotruyen = UserDefaults()
        
        
        pickerTT.delegate = self
        pickerTT.dataSource = self
        
        textFieldTT.inputView = pickerTT        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return danhsachchon.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = danhsachchon[indexPath.row]
        
        return cell
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var selectedIndex = self.mytableView.indexPath(for: sender as! UITableViewCell)
        
        let chon:Int! = selectedIndex?.row
        
        thamsotruyen.set(String(chon), forKey: "dong")
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBOutlet weak var textFieldTT: UITextField!
    var trangthai = ["Lưu", "Không Lưu", "lưu bảo mật"]
    var pickerTT = UIPickerView()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return trangthai.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerTT{
            return trangthai[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            textFieldTT.text = trangthai[row]
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //keyboard shows
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        moveTextField(textField: textField, moveDistance: -50, up: true)
    }
    
    //keyboard hidden
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        moveTextField(textField: textField, moveDistance: -50, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
}
