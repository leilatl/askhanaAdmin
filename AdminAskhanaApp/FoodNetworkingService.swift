//
//  FoodNetworkingService.swift
//  AdminAskhanaApp
//
//  Created by Leila Tolegenova on 09.06.2022.
//

import Foundation
import SwiftKeychainWrapper

struct ShowOrder: Codable{
    var id: Int
    var order_date: String
    var order_amount: Int
    var order_status: String
    var order_details: [ShowOrderDetails]
}
struct ShowOrderDetails: Codable{
    var id: Int
    var order_id: Int
    var quantity: Int
    var product_order_details: Meal
    
}
struct Meal: Codable {
    
    var name: String
    var slug: String
    var price: Int
    var protein: Int
    var fats: Int
    var carbs: Int
    var description: String
    var available_inventory: Int
    var category_id: Int
    var id: Int
}

struct UserCreation: Codable{
    var username: String
    var first_name: String
    var last_name: String
    var email: String
    var phone: String
    var balance: Int
    var password: String
    var is_staff: Bool
}
class FoodNetworkingService{
    let authorizedService = AuthorizedNetworkingService()
    
    func getOrders(completion: (([ShowOrder])->())?){
        
        let url = "https://ashana-app-dproj.herokuapp.com/orders/all"
        
        let requestProvider = AuthorizedRequestProvider(urlString: url,
                                              httpMethod: "GET")
        authorizedService.fetch(requestProvider: requestProvider, completion: completion)
    }
    
    func updateBalance(balance: Balance){
        let url = URL(string: "https://ashana-app-dproj.herokuapp.com/users/balance")
        guard let requestURL = url else {fatalError()}
        var request = URLRequest(url: requestURL)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let accessToken: String = KeychainWrapper.standard.string(forKey: "access_token")!
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        let newUser = balance
        
        let jsonData = try! JSONEncoder().encode(newUser)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                print("Response: \n \(dataString)")
            }
                
            
        }
        task.resume()
        
    }
    
    
    func createUser(user: UserCreation) {
        let url = URL(string: "https://ashana-app-dproj.herokuapp.com/users/")
        guard let requestURL = url else {fatalError()}
        var request = URLRequest(url: requestURL)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let newUser = user
        
        let jsonData = try! JSONEncoder().encode(newUser)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                print("Response: \n \(dataString)")
            }
            
            
        }
        task.resume()
        
    }
    
}
