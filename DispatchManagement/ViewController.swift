//
//  ViewController.swift
//  DispatchManagement
//
//  Created by VanThu on 16/02/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    func checkReachability(){
        if currentReachabilityStatus == .reachableViaWiFi{
            //print("dsadas")
        }
        else if currentReachabilityStatus == .reachableViaWWAN{
            //print("fdsfds")
        }else{
            let myAlert = "Vui lòng kiểm tra kết nối Internet!"
            isMyAlert(ismyAlert: myAlert)
        }
        
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        checkReachability()
        
        let username:String = txtUsername.text!
        let password:String = txtPassword.text!
        
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: username)
        let isPasswordValid = isValidPassword(passwordString: password)
        
        if(username == "" && password == ""){
            let myAlert = "Vui lòng nhập Email và Password!"
            isMyAlert(ismyAlert: myAlert)
        }
        
        else if username == "" {
            let myAlert = "Vui lòng nhập Email!"
            isMyAlert(ismyAlert: myAlert)
        }
        
        else if isEmailAddressValid == false{
            let myAlert = "Email sai định dạng!"
            isMyAlert(ismyAlert: myAlert)
        }
            
        else if password == "" {
            let myAlert = "Vui lòng nhập Password!"
            isMyAlert(ismyAlert: myAlert)
        }
        
        else if isPasswordValid == false{
            let myAlert = "Password yêu cầu tối thiểu 6 ký tự!"
            isMyAlert(ismyAlert: myAlert)
        }
            
        else{
            
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            
            
            let url:String = "https://masterdocs.herokuapp.com/api/authenticate"
            var urlRequest = URLRequest(url	: URL(string: url)!)
            urlRequest.httpMethod = "POST"
        
            let data: String = "username=" + username + "&password=" + password
            urlRequest.httpBody = data.data(using: .utf8)
        
            let session = URLSession.shared
    
            let task = session.dataTask(with: urlRequest) {
                (data, response, error) in
                guard error == nil else {
                    print("error calling POST")
                    return
                }
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
            
                do {
                    guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,options: []) as? [String: Any]
                        else {
                            print("Could not get JSON from responseData as dictionary")
                            return
                    }
                
                    guard let status = receivedTodo["status"] as? String else {
                        print("Could not get status as string from JSON")
                        return
                    }
                    
            
                    if(status == "false"){

                        let myAlert = "Nhập sai Email hoặc Password!"
                        self.isMyAlert(ismyAlert: myAlert)

                    }
                    else{
                        self.performSegue(withIdentifier: "login", sender: nil)
                    }
                    print("Status: \(status)")
                    
                } catch {
                    print("error parsing response from POST on /todos")
                    return
                }
            
            }
            task.resume()
            
            
        }
    }
    
    func isMyAlert(ismyAlert: String){
        let myAlert = UIAlertController(title: "Thông Báo", message: ismyAlert, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            self.activityIndicator.stopAnimating()
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
 
    func isValidEmailAddress(emailAddressString: String) -> Bool{
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0{
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
    
    
    func isValidPassword(passwordString: String) -> Bool{
        var returnValue = true
        let passwordRegEx = "[A-Z0-9a-z]{5}[A-Z0-9a-z]+"
        
        do {
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = passwordString as NSString
            let results = regex.matches(in: passwordString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0{
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

}
