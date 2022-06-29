//
//  SignUpDBHelper.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import Foundation
import UIKit
import CoreData

class SignUpDBHelper{
    
    static var dataStoreHelper = SignUpDBHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveUserInfo(username: String, password: String, isRememberStatus: Bool){
        let accountInfo = NSEntityDescription.insertNewObject(forEntityName: "SignUp", into: context!) as! SignUp
        accountInfo.usernameAttribute = username
        accountInfo.passwordAttribute = password
                
        
        do{
            try context?.save()
            print("user data saved")
        }
        catch{
            print("Error --> while saving user data")
        }

    }
    
    func getUserData() -> [SignUp] {
        var user = [SignUp]()
        let fetchDataRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SignUp")
        
        do{
            user = try context?.fetch(fetchDataRequest) as! [SignUp]
        }
        catch{
            print("error occurred while fetching user data!!!")
        }
        
        
        return user

    }
    
    func getUserData(name: String) -> SignUp {
        var user = SignUp()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SignUp")
        fetchRequest.predicate = NSPredicate(format: "usernameAttribute == %@", name)
        do{
            let request = try context?.fetch(fetchRequest) as! [SignUp]
            if request.count != 0 {
                user = request.first!
            }else{
                print("data not found")
            }
        }catch{
            print("error")
        }
        return user
    }
    
    
    //Functions for NOTE
    func saveNote(title: String, note: String){
        let noteDetails = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context!) as! Notes
        noteDetails.noteTitle = title
        noteDetails.noteBody = note
        
        do{
            try context?.save()
            print("note saved")
        }
        catch{
            print("Error --> while saving note")
        }

    }
    
    func getNotes() -> [Notes] {
        var myNotes = [Notes]()
        let fetchDataRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        
        do{
            myNotes = try context?.fetch(fetchDataRequest) as! [Notes]
        }
        catch{
            print("error occurred while fetching user data!!!")
        }
        
        
        return myNotes

    }
    
    //Experimental
    // comment
    func deleteNote(aNoteTitle: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "noteTitle == %@", aNoteTitle)
        
        do{
            let note = try context?.fetch(fetchRequest)
            context?.delete(note?.first as! Notes)
            try context?.save()
        }
        catch{
            print("Error ---> deleting NOTE")
        }
    }

    // comment

}
