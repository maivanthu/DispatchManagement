//
//  secondViewController.swift
//  DispatchManagement
//
//  Created by VanThu on 16/02/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit

class secondViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var textFieldLVB: UITextField!
    @IBOutlet weak var textFieldCQBH: UITextField!
    
    //let datePicker = UIDatePicker()
    
    @IBOutlet weak var textFieldNBH: UITextField!
    @IBAction func textFieldNBHEditing(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(secondViewController.datePickerValueChangedNBH), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChangedNBH(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        textFieldNBH.text = dateFormatter.string(from: sender.date)
    }
    
    @IBOutlet weak var textFieldNNVB: UITextField!
    @IBAction func textFieldNNVBEditing(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(secondViewController.datePickerValueChangedNNVB), for: UIControlEvents.valueChanged)
    }
    
    
    func datePickerValueChangedNNVB(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        textFieldNNVB.text = dateFormatter.string(from: sender.date)
    }
    
    var LVB = ["Van Ban 1", "Van Ban 2", "Van Ban 3"]
    var CQBH = ["Co quan 1", "Co quan 2", "Co quan 3"]
    var pickerLVB = UIPickerView()
    var pickerCQBH = UIPickerView()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows : Int = LVB.count
        if pickerView == pickerCQBH{
            countRows = CQBH.count
        }
        
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerLVB{
            return LVB[row]
        }
        else if pickerView == pickerCQBH{
            return CQBH[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerLVB{
            textFieldLVB.text = LVB[row]
        }
        if pickerView == pickerCQBH{
            textFieldCQBH.text = CQBH[row]
        }
    }
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerLVB.delegate = self
        pickerLVB.dataSource = self
        pickerCQBH.delegate = self
        pickerCQBH.dataSource = self
        
        textFieldLVB.inputView = pickerLVB
        textFieldCQBH.inputView = pickerCQBH
        
       // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        //Do any additional setup after loading the view.
    }
}
