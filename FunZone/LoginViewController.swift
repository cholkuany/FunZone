//
//  LoginViewController.swift
//  FunZone
//
//  Created by admin on 5/31/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var isRemember: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isRemember.isOn {
            isRemember.isOn = true //remove
            
            let data = SignUpDBHelper.dataStoreHelper.getUserData()
            for element in data {
                username.text = element.usernameAttribute
                break
            }
    
            let userInfoRequest : [String : Any] = [kSecClass as String : kSecClassGenericPassword,
                                                    kSecAttrAccount as String : username.text!,
                                        kSecReturnAttributes as String : true,
                                        kSecReturnData as String : true
                                       ]
            
            var userInfoResult : CFTypeRef?
            
        
            
            if SecItemCopyMatching(userInfoRequest as CFDictionary, &userInfoResult) == noErr {
                
                let userData = userInfoResult as? [String : Any]
                let accountName = userData![kSecAttrAccount as String] as? String
                let userPassword = (userData![kSecValueData as String] as? Data)!
                let pass = String(data : userPassword, encoding: .utf8)
                
                username.text = accountName
                password.text = pass
                
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarScreen = storyboard.instantiateViewController(withIdentifier: "tabBarController")
                //present(tabBarScreen, animated: true, completion: nil)
                navigationController?.pushViewController(tabBarScreen, animated: true) //remember to remove
                
                
                
            }
            else{
                //print("Error occurred!!!")
                username.text = ""
                password.text = ""
                isRemember.isOn = false
            }
            
        }

    

    }
    
    @IBAction func rememberActionStatus(_ sender: Any) {
        let pass = password.text ?? ""
        let user = username.text ?? ""
        if user.isEmpty  || pass.isEmpty{
            print("Make sure to enter username and password")
            password.backgroundColor = UIColor.red
            username.backgroundColor = UIColor.red
            isRemember.isOn = false
        }else{
            if isRemember.isOn {
                //isRemember.isOn = true //remove
                let userAccount : [String : Any] =  [
                                                   kSecClass as String: kSecClassGenericPassword,
                                                   kSecAttrAccount as String : username.text!,
                                                   kSecValueData as String : password.text?.data(using: .utf8)! ?? "Unknown"
                                                  ]
                if SecItemAdd(userAccount as CFDictionary, nil) == noErr {
                    print("I will remember you!!!")
                    
                }else {
                    print("Error -> remembering you!!!")
                }
                
            }else{
                //isRemember.isOn = false // remove
                let req : [String : Any] = [
                                        kSecClass as String : kSecClassGenericPassword,
                                        kSecAttrAccount as String : username.text!
                                       ]
                if SecItemDelete(req as CFDictionary) == noErr {
                    print("user deleted keychain!!!")
                    
                }else{
                    print("Error while deleting user")
                    
                }
                
            }
            
        }
    }
    
    @IBAction func signValidation(_ sender: Any) {
        
        //let pass = password.text!
        //let username = username.text!
        
        let pass = password.text ?? ""
        let aUser = username.text ?? ""
        if aUser.isEmpty  || pass.isEmpty{
            print("Make sure to enter username and password")
            password.backgroundColor = UIColor.red
            username.backgroundColor = UIColor.red
            isRemember.isOn = false
            
        }else{
            password.backgroundColor = UIColor.white
            username.backgroundColor = UIColor.white
            let user = SignUpDBHelper.dataStoreHelper.getUserData(name: aUser)
            if (aUser == user.usernameAttribute! && pass == user.passwordAttribute!){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarScreen = storyboard.instantiateViewController(withIdentifier: "tabBarController")
                //present(tabBarScreen, animated: true, completion: nil)
                navigationController?.pushViewController(tabBarScreen, animated: true) //remember to remove
        }
    }
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "signUpController") as? SignUpViewController
        signUpViewController?.completion = {
            self.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(signUpViewController!, animated: true)
    }
    
    
}
