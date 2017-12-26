//
//  LoginViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/23/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import SwiftSpinner

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initKeyboard()
        initTextFieldsStyling()
    }
    
    private func initKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard(gestureRecognizer:)))
        
        self.loginBackground.isUserInteractionEnabled = true
        self.loginBackground.addGestureRecognizer(tapRecognizer)
    }
    
    private func initTextFieldsStyling() {
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        let borderWidth = CGFloat(0.5)
        let cornerRadius = CGFloat(25)
        emailTextField.layer.borderWidth = borderWidth
        emailTextField.layer.borderColor = borderColor.cgColor
        emailTextField.layer.cornerRadius = cornerRadius
        
        let imageView = UIImageView();
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        imageView.contentMode = .right
        let image = UIImage(named: "email_blue");
        imageView.image = image;
        emailTextField.leftView = imageView;
        emailTextField.leftViewMode = UITextFieldViewMode.always
        emailTextField.leftViewMode = .always
        
        passwordTextField.layer.borderWidth = borderWidth
        passwordTextField.layer.borderColor = borderColor.cgColor
        passwordTextField.layer.cornerRadius = cornerRadius
        let imageView2 = UIImageView();
        imageView2.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        imageView2.contentMode = .right
        let image2 = UIImage(named: "lock_blue");
        imageView2.image = image2;
        passwordTextField.leftView = imageView2;
        passwordTextField.leftViewMode = UITextFieldViewMode.always
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
    }
    
    
    @IBAction func onSignInButtonDidTouch(_ sender: Any) {
        if (self.emailTextField.text! == "" || self.passwordTextField.text! == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Please innsert username and password." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            return;
        }else{
            SwiftSpinner.show("Signing in...").addTapHandler({
                SwiftSpinner.hide()
            }, subtitle: "Tap to hide. This will affect only the current operation.")
            LoginService.login(username: self.emailTextField.text!, password: self.passwordTextField.text!) { statusCode in
                
                SwiftSpinner.hide()
                
                if(statusCode == 200 || statusCode == 304){
                    self.performSegue(withIdentifier: "LoginSuccessSegue", sender: self)
                }else if(statusCode == 403 || statusCode == -6003){
                    let alertView = UIAlertController(title: "Login Problem",
                                                      message: "Wrong username or password." as String, preferredStyle:.alert)
                    let okAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                    alertView.addAction(okAction)
                    self.present(alertView, animated: true, completion: nil)
                }else{
                    let alertView = UIAlertController(title: "Network Problem",
                                                      message: "Network error." as String, preferredStyle:.alert)
                    let okAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                    alertView.addAction(okAction)
                    self.present(alertView, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -180
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
