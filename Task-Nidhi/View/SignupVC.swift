//
//  SignupVC.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import UIKit

class SignupVC: UIViewController {

    //MARK: - Outlets & Variables
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
    }
}

//MARK: - Action Methods
extension SignupVC{
    @IBAction func btnSignUp(_ sender: UIButton) {
        guard let username = txtEmail.text?.trim() else {
            return
        }
        
        guard let email = txtEmail.text?.trim() else {
            return
        }
        
        guard let mobile = txtMobileNo.text?.trim() else {
            return
        }
        
        guard let password = txtPassword.text?.trim() else {
            return
        }
        
        guard let confirmPass = txtConfirmPassword.text?.trim() else {
            return
        }
        
        let isValid = validateForm(password: password, email: email, username: username, mobileNo: mobile, confirmPassword: confirmPass)
        if isValid.0 {
            self.signup(password: password, email: email, username: username, mobileNo: mobile, confirmPassword: confirmPass)
        } else {
            self.showMessage(message: isValid.1)
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Signup Methods
extension SignupVC{
    func signup(password: String,
                      email: String, username: String, mobileNo: String, confirmPassword: String){
        DatabaseHelper.sharedInstance.saveUserDetails(name: username, email: email, password: password, mobile: mobileNo) { strError in
            if strError != ""{
                self.showMessage(message: strError)
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - Custom Methods
extension SignupVC{
    func commonInit(){
        
    }
    
    //MARK:- Validation
    func validateForm(password: String,
                      email: String, username: String, mobileNo: String, confirmPassword: String) -> (Bool, String) {
        if username.isEmpty {
            return (false, Validations.emptyName)
        }
        
        if email.isEmpty {
            return (false, Validations.emptyEmail)
        }
        
        if !(email.isValidEmail(email: email)){
            return (false, Validations.emptyEmailValidation)
        }
        
        if mobileNo.isEmpty {
            return (false, Validations.emptyMobileNo)
        }
        
        if password.isEmpty {
            return (false, Validations.emptyPassword)
        }
        
        if password.count < 6 {
            return (false, Validations.minimumSixCharacterPassword)
        }
        
        if confirmPassword.isEmpty {
            return (false, Validations.emptyConfirmPassword)
        }
        
        if password != confirmPassword{
            return (false, Validations.emptyPasswordNotMatch)
        }
        
        return (true, "")
    }
}

extension SignupVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
