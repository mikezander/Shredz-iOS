//
//  PostCell.swift
//  shredz_workspace
//
//  Created by Michael Alexander on 11/18/17.
//  Copyright © 2017 Michael Alexander. All rights reserved.
//
import UIKit
import AVFoundation
import AVKit
import Player

class PostCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var normalView: UIView!
    @IBOutlet weak var flippedView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var flippedTableView: UITableView!

    var localPlayer = AVQueuePlayer()
    var playerLayer: AVPlayerLayer?
    var videoAsset: AVAsset?
    var looper: AVPlayerLooper?

    var flipped = false {
        didSet {
            if flipped {
                localPlayer.pause()
                flippedTableView.reloadData()
            } else {
                localPlayer.play()
            }
        }
    }

    var videoUrl: URL? {
        didSet {
            initNewPlayerItem()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
     
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleFlip(_:)))
        swipe.direction = [.left, .right]

        contentView.addGestureRecognizer(swipe)

        intializeAVQueuePlayer()

        //flippedTableView.delegate = self
        //flippedTableView.dataSource = self
    }
    
    func intializeAVQueuePlayer() {
        //self.localPlayer = AVQueuePlayer.init()
        self.playerLayer = AVPlayerLayer(player: self.localPlayer)
        self.playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.playerLayer?.player = self.localPlayer
        videoView.layoutIfNeeded()
        self.playerLayer?.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer!)
    }

    func initNewPlayerItem() {

            self.localPlayer.removeAllItems()

            guard let videoPlayerUrl = videoUrl else {
                return
            }
        
        videoAsset = AVAsset(url: videoPlayerUrl)
        
        videoAsset!.loadValuesAsynchronously(forKeys: ["duration"]) {
               guard self.videoAsset!.statusOfValue(forKey: "duration", error: nil) == .loaded else {
                return
              }
            
            let videoPlayerItem = AVPlayerItem(asset: self.videoAsset!)
            
            self.looper = AVPlayerLooper(player: self.localPlayer, templateItem: videoPlayerItem)
            
            DispatchQueue.main.async {

                self.localPlayer.insert(videoPlayerItem, after: nil)
                
                }
        }
    }

    func playVideo() {
        self.localPlayer.play()
    }

    @objc func handleFlip(_ sender: UITapGestureRecognizer) {
        if !flipped{
            UIView.transition(with: contentView, duration: 0.6, options: .transitionFlipFromRight, animations: {() -> Void in
                self.contentView.insertSubview(self.flippedView, aboveSubview: self.normalView)
            }, completion: {(_ finished: Bool) -> Void in
            })
            flipped = true
        } else {
            UIView.transition(with: contentView, duration: 0.6, options: .transitionFlipFromLeft, animations: {() -> Void in
                self.contentView.insertSubview(self.normalView, aboveSubview: self.flippedView)
            }, completion: {(_ finished: Bool) -> Void in
            })
            flipped = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Some comment"
        return cell
    }
}





