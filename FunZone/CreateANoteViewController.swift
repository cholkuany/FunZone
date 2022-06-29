//
//  CreateANoteViewController.swift
//  FunZone
//
//  Created by admin on 6/2/22.
//

import UIKit

class CreateANoteViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    public var completion = {}
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveNote(_ sender: Any) {
        let title = titleField.text ?? ""
        let body = noteField?.text ?? ""
        if !title.isEmpty && !body.isEmpty {
            SignUpDBHelper.dataStoreHelper.saveNote(title: titleField.text!, note: noteField.text!)

            completion()
            
            
        }

    }
    
}
