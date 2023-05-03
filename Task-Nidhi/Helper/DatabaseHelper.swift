//
//  DatabaseHelper.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 25/04/23.
//

import Foundation
import CoreData
import UIKit

typealias CompletionHandler = () -> Void

class DatabaseHelper  {
    
    static var sharedInstance = DatabaseHelper()
    var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var completionHandler: CompletionHandler!
    
    func saveUserDetails(name: String, email: String, password: String, mobile: String,completion:@escaping (String) -> Void){
        let user = UserEntity(context: context!)

        // Assign values to the entity's properties
        user.username = name
        user.password = password
        user.mobile = mobile
        user.email = email

        // To save the new entity to the persistent store, call
        // save on the context
        if !self.someEntityExists(email: email){
            do {
                try context!.save()
            }
            catch {
                // Handle Error
            }
            completion("")
        }else{
            completion("Already have email id")
        }
        
    }
    
    func someEntityExists(email: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)

        var results: [NSManagedObject] = []

        do {
            results = try context!.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return results.count > 0
    }
    
    func userEntityExists(email: String, password: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        fetchRequest.predicate = NSPredicate(format: "email = %@ AND password = %@", email, password)

        var results: [NSManagedObject] = []

        do {
            results = try context!.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return results.count > 0
    }
    
    func saveProductDetails(count: Int, email: String, productid: String, productname: String, price: String,completion:@escaping (String) -> Void){
        
        var cart = CartEntity()
        let fetchRequest: NSFetchRequest<CartEntity> = CartEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format:"productid = %@", productid as CVarArg )

         let results = try? context!.fetch(fetchRequest)
        var itemCount = 1
         if results?.count == 0 {
            // here you are inserting
             cart = CartEntity(context: context!)
         } else {
            // here you are updating
             cart = (results?.first)!
             itemCount = Int(cart.count!)! + count
         }

        // Assign values to the entity's properties
        cart.productid = productid
        cart.count = "\(itemCount)"
        cart.productname = productname
        cart.email = email
        cart.price = price

        // To save the new entity to the persistent store, call
        // save on the context
        do {
            try context!.save()
        }
        catch {
            // Handle Error
        }
        completion("")
        
    }
    
    public func fetchUserDetail(completion:@escaping ([UserModel]) -> Void){
        var details = [UserModel]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        do {
            let fetchingData = try context!.fetch(fetchRequest)
            print(fetchingData)
            for data in fetchingData as! [NSManagedObject] {
//                    print(data.value(forKey: "email") as! String)
                details.append(UserModel(name: data.value(forKey: "username") as! String, email: data.value(forKey: "email") as! String, password: data.value(forKey: "password") as! String, mobile: data.value(forKey: "mobile") as! String))
            }
            completion(details)
        } catch {
            print("Error while fetching the image")
        }
    }
//
//    public func deleteEmployeeDetail(id: String, completion:@escaping (Bool) -> Void){
//        let fetchRequest: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format:"id = %@", id as CVarArg)
//
//        let objects = try! context!.fetch(fetchRequest)
//        for obj in objects {
//            context!.delete(obj)
//        }
//
//        do {
//            try context!.save()
//        } catch {
//            // Do something... fatalerror
//        }
//        completion(true)
//    }
//
//    func editData(name: String, birthdate: String, surname: String, image: Data, id: String){
//        var user = EmployeeEntity()
//        let fetchRequest: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format:"id = %@", id as CVarArg )
//
//         let results = try? context!.fetch(fetchRequest)
//
//         if results?.count == 0 {
//            // here you are inserting
//            user = EmployeeEntity(context: context!)
//         } else {
//            // here you are updating
//             user = (results?.first)!
//         }
//
//         user.id = id
//         user.name = name
//        user.surname = surname
//        user.image = image
//        user.birthdate = birthdate
//
//        do {
//            try context!.save()
//        } catch {
//            // Do something... fatalerror
//        }
//    }
    
}
