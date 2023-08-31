//
//  BalanceViewController.swift
//  AdminAskhanaApp
//
//  Created by Leila Tolegenova on 09.06.2022.
//

import UIKit

class BalanceViewController: UIViewController {
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var sumTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func updateBalance(_ sender: Any) {
        let service = FoodNetworkingService()
        let newBalance = Balance(phone: phoneTF.text!, balance: Int(sumTF.text!)!)
        service.updateBalance(balance: newBalance)
        
    }
    


}
struct Balance: Codable{
    var phone: String
    var balance: Int
}
