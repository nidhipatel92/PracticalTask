//
//  ViewController.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: - Outlets & Variables
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Action Methods
extension LoginVC{
    @IBAction func btnLogin(_ sender: UIButton) {
        guard let email = txtEmail.text?.trim() else {
            return
        }
        
        guard let password = txtPassword.text?.trim() else {
            return
        }
        
        let isValid = validateForm(password: password,
                                   email: email)
        if isValid.0 {
            self.login(email: email, password: password)
        } else {
            self.showMessage(message: isValid.1)
        }
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        let objSignUp = UIStoryboard.main.instantiate(type:SignupVC.self)
        self.navigationController?.pushViewController(objSignUp, animated:true)
    }
}

//MARK: - Login Methods
extension LoginVC{
    func login(email: String, password: String){
        if DatabaseHelper.sharedInstance.userEntityExists(email: email, password: password){
            print("Login")
            userdefault.set(email, forKey: Keys.email)
            let objDashboard = UIStoryboard.main.instantiate(type:DashboardVC.self)
            self.navigationController?.pushViewController(objDashboard, animated:true)
        }else{
            self.showMessage(message: "Email id does not exists")
        }
    }
}

//MARK: - Custom Methods
extension LoginVC{
    func commonInit(){
        
    }
    
    //MARK:- Validation
    func validateForm(password: String,
                      email: String) -> (Bool, String) {
        
        if email.isEmpty {
            return (false, Validations.emptyEmail)
        }
        
        if !(email.isValidEmail(email: email)){
            return (false, Validations.emptyEmailValidation)
        }
        
        if password.isEmpty {
            return (false, Validations.emptyPassword)
        }
        
        if password.count < 6 {
            return (false, Validations.minimumSixCharacterPassword)
        }
        
        return (true, "")
    }
}

extension LoginVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
