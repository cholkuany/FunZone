//
//  BooksViewController.swift
//  FunZone
//
//  Created by admin on 5/29/22.
//

import UIKit
import PDFKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var BooksCollectionView: UICollectionView!
    @IBOutlet weak var searchBarLabel: UISearchBar!
    
    var books = [["Matthew Kelly", "Resisting Happiness"], ["Shakti Gawain", "Living in the Light"], ["Not Matthew", "Not Resisting Happiness"]]
    //var authorsArray = ["Matthew Kelly", "Shakti Gawain", "Matthew Kelly"]
    var booksArray = ["book2", "bookSample", "book3"]

    var filteredBooks = [[String]]()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Books"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return filteredBooks.count
        }else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myBook = collectionView.dequeueReusableCell(withReuseIdentifier: "book", for: indexPath) as! BooksCollectionViewCell
        if searching{
            myBook.bookTitle.text = filteredBooks[indexPath.row][1]
            myBook.authorName.text = filteredBooks[indexPath.row][0]
        }else{
            myBook.bookTitle.text = books[indexPath.row][1]
            myBook.authorName.text = books[indexPath.row][0]
        }
        return myBook
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let bookPDFController = storyObject.instantiateViewController(withIdentifier: "bookPdf") as! BooksPDFViewController
        bookPDFController.bookName = booksArray[indexPath.row]
        //self.present(bookPDFController, animated: true, completion: nil)
        navigationController?.pushViewController(bookPDFController, animated: true) // to be removed
    }

}
extension BooksViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBooks = books.filter({$0[1].lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        self.BooksCollectionView.reloadData()
    }
    
}
