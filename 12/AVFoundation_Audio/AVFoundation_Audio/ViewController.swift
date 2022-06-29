//
//  ViewController.swift
//  AVFoundation_Audio
//
//  Created by Niki Pavlove on 18.02.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var Player = AVAudioPlayer()
    
    var playList = ["Queen", "Artbat - keep calm (feat.dino lenny)", "Shah - i don't wanna know (feat.brenda mullen)", "Bad boys blue - you're a woman", "Modern talking - you're my heart youre my soul", "DMX - party up"]
    
    lazy var currentSong = playList[0]

    override func viewDidLoad() {
        super.viewDidLoad()
        audioNameLabel.text = currentSong
        do {
            Player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currentSong, ofType: "mp3")!))
            Player.prepareToPlay()
        }
        catch {
            print(error)
        }
        
    }

    @IBOutlet weak var audioNameLabel: UILabel!
    
    @IBAction func PlayButton(_ sender: Any) {
        Player.play()
    }
    
    @IBAction func PauseButton(_ sender: Any) {
        if Player.isPlaying {
            Player.stop()
        }
        else {
            print("Already stopped!")
        }
    }
    
    @IBAction func StopButton(_ sender: Any) {
        if Player.isPlaying {
            Player.stop()
            Player.currentTime = 0
        }
        else {
            print("Already stopped!")
        }
    }

}
