//
//  ViewController.swift
//  AdminAskhanaApp
//
//  Created by Leila Tolegenova on 09.06.2022.
//

import UIKit
import SwiftKeychainWrapper

struct LogInCredentials: Codable{
    var email: String
    var password: String
}

class ViewController: UIViewController {

    @IBOutlet weak var registrationBtnOutlet: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        if emailTextField.hasText && passwordTextField.hasText{
            let email = emailTextField.text
            let password = passwordTextField.text!
            
            let url = URL(string: "https://ashana-app-dproj.herokuapp.com/login")
            guard let requestURL = url else {fatalError()}
            var request = URLRequest(url: requestURL)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            let credentials = LogInCredentials(email: email!, password: password)
            let jsonData = try! JSONEncoder().encode(credentials)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                
                if let error = error {
                    print("Error took place \(error)")
                    //status = false
                    return
                }
                
                if let data = data, let dataString = String(data: data, encoding: .utf8){
                    print("Response: \n \(dataString)")
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = json{
                            if let accessToken = parseJSON["access_token"] as? String{
                                let tokenType = parseJSON["token_type"] as? String
                                //print(accessToken!)
                                //print(tokenType!)
                                //status = true
                                DispatchQueue.main.async {
                                    let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabController") as! TabController
                                     tabController.modalPresentationStyle = .fullScreen
                                    self.present(tabController, animated: true)
                                }
                                
                                
                                let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken, forKey: "access_token")
                                let saveTokenType: Bool = KeychainWrapper.standard.set(tokenType!, forKey: "token_type")
                            }
                            
                        }else{
                            print("ERRORRR")
                            
                            //status = false
                        }
                    }catch{
                        
                    }
                    
                    
                }
                    
                
            }
            task.resume()
            
        }else{
            
        }
    }
    

}

