//
//  LoginViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/23/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextFieldsStyling()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
