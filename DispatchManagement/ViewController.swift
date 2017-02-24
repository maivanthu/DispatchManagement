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
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let username:String = txtUsername.text!
        let password:String = txtPassword.text!
        
        if(username == "" || password == ""){
            let myAlert = UIAlertController(title: "Thông Báo", message: "Vui lòng nhập Email và Password!", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
                //print("Đã nhập")
            }
        
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
            //let login = storyboard?.instantiateViewController(withIdentifier: "login")
        //present(login!, animated: true, completion: nil)
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

                        let myAlert = UIAlertController(title: "Thông Báo", message: "Nhập sai Email hoặc Password!", preferredStyle: UIAlertControllerStyle.alert)
                        
                                               
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
                            //print("Đã nhập")
                            self.activityIndicator.stopAnimating()
                        }
                        
                        
                        myAlert.addAction(okAction)
                        self.present(myAlert, animated: true, completion: nil)

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
