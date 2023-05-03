//
//  Extension.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    public static var main : UIStoryboard {
        UIStoryboard(name:"Main", bundle:nil)
    }
    
    public func instantiate<Vc : UIViewController>(type : Vc.Type) -> Vc {
        guard let vc = self.instantiateViewController(withIdentifier:String(describing:type.self)) as? Vc else {
            fatalError("Could not instantiate view controller \(Vc.self)") }
          return vc
    }
    
}

extension UIViewController {
    func showMessage(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension String {
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    public func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
