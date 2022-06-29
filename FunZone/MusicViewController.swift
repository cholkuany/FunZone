//
//  MusicViewController.swift
//  FunZone
//
//  Created by admin on 5/29/22.
//

import UIKit
import AVFoundation
import Foundation

class MusicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var musicCollectionView: UICollectionView!
    var songsArray = ["blake"]
    var musicArray = [["Seek & Destroy", "Metallica"], ["God's Country", "Blake Sheldon"], ["City of Gods", "Kanye West"],
                       ["Bartender", "T-pain"], ["Juicy", "Biggy"], ["Bad Blood", "Taylor Swift"],
                       ["Sway", "Micheal Buble"], ["Coupe bibama", "Awilo"], ["Landlord", "Major"]]
    
    var filteredMusic = [[String]]()
    var search = false

    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if search {
            return filteredMusic.count
        }else{
            return 9
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myMusic = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        if search {
            myMusic.artist.text = filteredMusic[indexPath.row][1]
            myMusic.songTitle.text = filteredMusic[indexPath.row][0]
            
        }else{
            myMusic.artist.text = musicArray[indexPath.row][1]
            myMusic.songTitle.text = musicArray[indexPath.row][0]
        }
        
        myMusic.backgroundColor = UIColor.black
        return myMusic
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let playSongController = storyObject.instantiateViewController(withIdentifier: "playSong") as! PlaySongViewController
        playSongController.songName = songsArray[0]
        navigationController?.pushViewController(playSongController, animated: true)

    }

}

extension MusicViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMusic = searchText.isEmpty ? musicArray : musicArray.filter({
            if $0[1].lowercased().prefix(searchText.count) == searchText.lowercased(){
                return true
            }
            return false
        })
        search = true
        self.musicCollectionView.reloadData()
    }
    
}
