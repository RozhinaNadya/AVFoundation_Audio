//
//  Created by Netology on 18.06.2021.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    

    private lazy var streamURL1 = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")!
    
    private lazy var streamURL2 = URL(string: "https://youtu.be/Kv2dQZM022w")
    
    lazy var dataTableView = ["Demo" : streamURL1, "demo2" : streamURL2]

    private lazy var localURL: URL = {
        let path = Bundle.main.path(forResource: "test", ofType: "mp4")!
        return URL(fileURLWithPath: path)
    }()

    @IBOutlet weak var tableView: UITableView!
    
    func playVideo(video: URL) {
    // Создаём AVPlayer со ссылкой на видео.
        let player = AVPlayer(url: video)

        // Создаём AVPlayerViewController и передаём ссылку на плеер.
        let controller = AVPlayerViewController()
        controller.player = player

        // Показываем контроллер модально и запускаем плеер.
        present(controller, animated: true) {
            player.play()
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
        playVideo(video: videoURL!)

    }
}
