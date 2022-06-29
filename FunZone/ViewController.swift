//
//  ViewController.swift
//  FunZone
//
//  Created by admin on 5/25/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate{
    

    @IBOutlet weak var mysearchBar: UISearchBar!
    @IBOutlet weak var notesTableView: UITableView!
    
    var notesData: [Notes]!
    var filteredNotes: [Notes]! // remove this line
    var search = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NOTES"
        notesData = SignUpDBHelper.dataStoreHelper.getNotes()
        //filteredNotes = notesData                                     //remove this line
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search {
            return filteredNotes.count
        }else{
            return notesData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = notesTableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath)
        if search {
            cell.textLabel?.text = filteredNotes[indexPath.row].noteTitle
            cell.detailTextLabel?.text = filteredNotes[indexPath.row].noteBody
        }else{
            cell.textLabel?.text = notesData[indexPath.row].noteTitle
            cell.detailTextLabel?.text = notesData[indexPath.row].noteBody

        }

        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mysearchBar.resignFirstResponder()
        tableView.deselectRow(at: indexPath, animated: true)
        let displayNote = notesData[indexPath.row] //this is the note to be displayed
        
        let displayNoteViewController = storyboard?.instantiateViewController(withIdentifier: "aNote") as? DisplayNoteViewController
        displayNoteViewController?.title = notesData[indexPath.row].noteTitle
        
        displayNoteViewController?.myTitle = displayNote.noteTitle                 //filteredNotes[indexPath.row].noteTitle
        displayNoteViewController?.myNote = displayNote.noteBody
        
        //-----------------------------
        displayNoteViewController?.completion = {
            self.navigationController?.popViewController(animated: true)
            self.notesData = SignUpDBHelper.dataStoreHelper.getNotes()
            self.notesTableView.reloadData()
        
        }
        //----------------------------
        
        
        navigationController?.pushViewController(displayNoteViewController!, animated: true)
    }
    
    @IBAction func addNote(){
        mysearchBar.resignFirstResponder()
        let createNoteViewController = storyboard?.instantiateViewController(withIdentifier: "newNote") as? CreateANoteViewController
        createNoteViewController?.title = "New Note"
        createNoteViewController?.completion = {
            self.navigationController?.popViewController(animated: true)
            self.notesData = SignUpDBHelper.dataStoreHelper.getNotes()
            self.notesTableView.reloadData()
        }
        
        navigationController?.pushViewController(createNoteViewController!, animated: true)
        


    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotes = searchText.isEmpty ? notesData : notesData.filter({ $0.noteTitle!.lowercased().prefix(searchText.count) == searchText.lowercased()
        })
        search = true
        self.notesTableView.reloadData()
        
    }
    
}

