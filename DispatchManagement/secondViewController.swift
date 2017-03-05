//
//  secondViewController.swift
//  DispatchManagement
//
//  Created by VanThu on 16/02/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit
import Alamofire

class secondViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textFieldSVBD: UITextField!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var textFieldLVB: UITextField!
    @IBOutlet weak var textFieldCQBH: UITextField!
    @IBOutlet weak var textFieldNXL: UITextField!
    @IBOutlet weak var textFieldND: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var output: UILabel!
    

    @IBAction func `switch`(_ sender: UISwitch) {
        
        
        if sender.isOn == true{
            output.text = "Gap"
        }
        else{
            output.text = "Khong"
        }
        
    }
    
    @IBAction func getFile(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: "choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "camera", style: .default, handler: {(action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                image.sourceType = .camera
                self.present(image, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "photo libary", style: .default, handler: {(action: UIAlertAction) in
            image.sourceType = .photoLibrary
            self.present(image, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.image = img
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    

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
    var NXL = ["Nguyen A", "Nguyen B", "Mai van Thu"]
    var pickerLVB = UIPickerView()
    var pickerCQBH = UIPickerView()
    var pickerNXL = UIPickerView()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.viewScroll.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows : Int = LVB.count
        if pickerView == pickerCQBH{
            countRows = CQBH.count
        } else if pickerView == pickerNXL{
            countRows = NXL.count
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
        else if pickerView == pickerNXL{
            return NXL[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerLVB{
            textFieldLVB.text = LVB[row]
        }
        else if pickerView == pickerCQBH{
            textFieldCQBH.text = CQBH[row]
        }
        else{
            textFieldNXL.text = NXL[row]
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
        pickerNXL.delegate = self
        pickerNXL.dataSource = self
        textFieldND.delegate = self
        textFieldNBH.delegate = self
        textFieldNNVB.delegate = self
        textFieldSVBD.delegate = self
        
        textFieldLVB.inputView = pickerLVB
        textFieldCQBH.inputView = pickerCQBH
        textFieldNXL.inputView = pickerNXL
        
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondViewController.dismissKeyboard)))
        //Do any additional setup after loading the view.
    }
    
    func dismissKeyboard(){
        textFieldLVB.resignFirstResponder()
        textFieldCQBH.resignFirstResponder()
        textFieldNXL.resignFirstResponder()
        textFieldND.resignFirstResponder()
        textFieldNBH.resignFirstResponder()
        textFieldNNVB.resignFirstResponder()
        textFieldSVBD.resignFirstResponder()
    }
    
    @IBAction func btnChuyenXuLy(_ sender: Any) {
        
        if (textFieldSVBD.text == "" || textFieldLVB.text == "" || textFieldNBH.text == "" || textFieldCQBH.text == "" || textFieldNNVB.text == "" || textFieldND.text == "" || output.text == "" || textFieldNXL.text == "" || imgView.image == nil){
            let myAlert = "Vui lòng nhập đầy đủ thông tin!"
            isMyAlert(ismyAlert: myAlert)
        }
        else{
            myImageUploadRequest()
        }
        
        
    }
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    func myImageUploadRequest()
    {
        
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        
        let myUrl = NSURL(string: "https://masterdocs.herokuapp.com/api/document")
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        let param = [
            "SoVanBan"  : textFieldSVBD.text!,
            "LoaiVanBan"    : textFieldLVB.text!,
            "NgayBanHanh"    : textFieldNBH.text!,
            "CoQuanBanHanh" :   textFieldCQBH.text!,
            "NgayNhanVanBan" :  textFieldNNVB.text!,
            "TrichYeu"  :   textFieldND.text!,
            "Gap"   :   output.text!,
            "NguoiXuLy" :   textFieldNXL.text!
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(imgView.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "FileDinhKem", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
        //myActivityIndicator.startAnimating();
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                //print(json as Any)
                guard let status = json?["status"] as? String else {
                    print("Could not get status as string from JSON")
                    return
                }
                if(status == "success"){
                    
                    let myAlert = UIAlertController(title: "Thông Báo", message: "Tạo thành công!", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
                        self.activityIndicator.stopAnimating()
                        
                        self.textFieldSVBD.text = ""
                        self.textFieldLVB.text = ""
                        self.textFieldNBH.text = ""
                        self.textFieldCQBH.text = ""
                        self.textFieldNNVB.text = ""
                        self.textFieldND.text = ""
                        self.output.text = ""
                        self.textFieldNXL.text = ""
                        self.imgView.image = nil
                        
                    }
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                }
                print("Status: \(status)")
            } catch {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func isMyAlert(ismyAlert: String){
        let myAlert = UIAlertController(title: "Thông Báo", message: ismyAlert, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            self.activityIndicator.stopAnimating()
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
}
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

