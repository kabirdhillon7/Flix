//
//  YTPlayerViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 12/18/22.
//

import UIKit
import youtube_ios_player_helper

class YTPlayerViewController: UIViewController {
    
    @IBOutlet var playerView: YTPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.load(withVideoId: "")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
