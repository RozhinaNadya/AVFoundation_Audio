//
//  Created by Netology on 18.06.2021.
//

import UIKit
import AVFoundation
import AVKit
import youtube_ios_player_helper
import XCDYouTubeKit

class ViewController: UIViewController, YTPlayerViewDelegate {
        
    private lazy var streamURL1 =  "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8"

    
    private lazy var streamURL2 = "t5ZLFM33EIM&ab_channel=Planeperworld"
    
    lazy var dataTableView = ["Demo" : streamURL1, "demo2" : streamURL2]

    private lazy var localURL: URL = {
        let path = Bundle.main.path(forResource: "test", ofType: "mp4")!
        return URL(fileURLWithPath: path)
    }()

    @IBOutlet weak var tableView: UITableView!
    
    func playVideo(video: String) {
        print("play demo")
        let myVideo = URL(string: video)!
        let player = AVPlayer(url: myVideo)

        let controller = AVPlayerViewController()
        controller.player = player

        present(controller, animated: true) {
            player.play()
        }
    }
    
    func playYoutubeVideo(video: String) {
        print("play youtube")

        let controller = AVPlayerViewController()

        XCDYouTubeClient.default().getVideoWithIdentifier(video) { [weak controller] (video: XCDYouTubeVideo?, error: Error?) in
            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
                controller?.player = AVPlayer(url: streamURL)
            }
        }
        present(controller, animated: true) {
            controller.player?.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
        var nameCell: [String] = []
        for (key, value) in dataTableView {
            nameCell.append(key)
        }
        cell.textLabel?.text = "\(nameCell[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: index!)
        guard let key = currentCell?.textLabel?.text else { return }
        guard let videoURL = dataTableView[key] else {return}
        if videoURL.hasPrefix("http") {
            playVideo(video: videoURL)
        } else {
            playYoutubeVideo(video: videoURL)

        }
    }
}

struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}
