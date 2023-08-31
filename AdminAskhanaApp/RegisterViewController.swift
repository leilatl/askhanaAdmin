//
//  RegisterViewController.swift
//  AdminAskhanaApp
//
//  Created by Leila Tolegenova on 09.06.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func registerPressed(_ sender: Any) {
        
        if nameTextField.hasText && surnameTextField.hasText && numberTextField.hasText && emailTextField.hasText{
            let service = FoodNetworkingService()
            let newUser = UserCreation(username: nameTextField.text ?? "nul", first_name: nameTextField.text ?? "nul", last_name: surnameTextField.text ?? "nul", email: emailTextField.text ?? "nul", phone: numberTextField.text ?? "nul", balance: 10000, password: passwordTextField.text ?? "nul", is_staff: true)
            service.createUser(user: newUser)
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }else{
        }
        
        

       
    }

}
