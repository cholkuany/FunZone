//
//  DisplayNoteViewController.swift
//  FunZone
//
//  Created by admin on 6/2/22.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
   // @IBOutlet var titleLabel: UILabel! label was removed. put back if needed
    @IBOutlet var noteTextView: UITextView!
    
    public var myTitle: String!
    public var myNote: String!
    
    public var completion = {} //: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        //titleLabel.text = myTitle   // this was removed
        noteTextView.text = myNote
    }
    
    //Experimental
    //comment
    @IBAction func deleteNote(_ sender: Any) {
        SignUpDBHelper.dataStoreHelper.deleteNote(aNoteTitle: myTitle)
        completion() //?()
        
    }
     //comment
    
}
