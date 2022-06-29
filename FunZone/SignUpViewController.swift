//
//  SignUpViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var rememberSwitchStatus: UISwitch!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    public var completion = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberSwitchStatus.isOn = false

    }
    
    @IBAction func rememberUser(_ sender: Any) {
        //rememberSwitchStatus.isOn = true
        let pass = password.text ?? ""
        let user = userName.text ?? ""
        if user.isEmpty  || pass.isEmpty{
            print("Make sure to enter username and password")
            rememberSwitchStatus.isOn = false
        }else{
            let userAccount : [String : Any] =  [
                                               kSecClass as String: kSecClassGenericPassword,
                                               kSecAttrAccount as String : userName.text!,
                                               kSecValueData as String : password.text?.data(using: .utf8)! ?? "Unknown"
                                              ]
            if SecItemAdd(userAccount as CFDictionary, nil) == noErr {
                print("I will remember you!!!")
             }else {
                print("Error -> remembering you!!!")
             }
        }

    }
    
    @IBAction func submitValidation(_ sender: Any) {
        let pass = password.text ?? ""
        let user = userName.text ?? ""
        if user.isEmpty  || pass.isEmpty{
            print("Make sure to enter username and password")
            password.backgroundColor = UIColor.red
            userName.backgroundColor = UIColor.red
        }else{
            SignUpDBHelper.dataStoreHelper.saveUserInfo(username: userName.text!, password: password.text!, isRememberStatus: rememberSwitchStatus.isOn)
            completion()
            
        }
    }
    
}
