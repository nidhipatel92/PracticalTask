//
//  APIClass.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import Foundation
import UIKit


class APIClass{
    static var sharedInstance = APIClass()
    
    func getProductDetails(completion:@escaping ([Product],String?) -> Void){
        var request = URLRequest(url: URL(string: URLs.getproduct)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("utf-8", forHTTPHeaderField: "Accept-Charset")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            guard error == nil else {
                return
            }
            do {
//                let json = try JSONSerialization.jsonObject(with:data!) as? [[String: Any]]
//                print("\(json)")
//                guard json != nil else {
//                    return
//                }
                let getData = try JSONDecoder().decode([Product].self, from: data!)
//                print("\(nav)")
                completion(getData,"")
               print("Get Value")
            } catch {
                print("error")
                completion([], "Error")
            }
        })

        task.resume()
    }
    
    func getDictionaryFromJsonString(dictString:String)-> [String: Any] {
            do {
                return try  JSONSerialization.jsonObject(with:
                dictString.data(using:
                String.Encoding.utf8, allowLossyConversion: true)!, options:
                 JSONSerialization.ReadingOptions.allowFragments) as! Dictionary
            } catch {
                return [:]
            }
        }
    
}
