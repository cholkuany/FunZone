//
//  PlaySongViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import UIKit
import AVFoundation

class PlaySongViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    var songName: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = Bundle.main.path(forResource: songName, ofType: "mp3")
        let url = URL(fileURLWithPath: filePath!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        }
        catch{
            print("file not found")
        }

    }
    
    @IBAction func playMusic(_ sender: Any) {
        audioPlayer?.play()
        print("Your music is playing....")


    }
    
    @IBAction func stopMusic(_ sender: Any) {
        
        audioPlayer?.stop()
        print("Your music is stopped....")

    }
    

}
