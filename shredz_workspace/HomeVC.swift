//
//  HomeVC.swift
//  shredz_workspace
//
//  Created by Michael Alexander on 11/17/17.
//  Copyright © 2017 Michael Alexander. All rights reserved.
//

import Foundation
import UIKit


class HomeVC: UIViewController {

    let saveFileName = "/test.mp4"
    var scrolling = false
   
    @IBOutlet weak var postCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.reloadData()

    }
    
    func getUrlFromCameraRoll() -> URL{
        // find video url
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
        let dataPath = documentsDirectory.appendingPathComponent(saveFileName)
        return dataPath
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell


        cell.videoUrl = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") //getUrlFromCameraRoll()
        

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell

       // if let cells = postCollectionView.visibleCells as? [PostCell] {
            //for cell in cells {
                //cell.playVideo()
           // }
       // }
        

    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       // if let cell = cell as? PostCell {
       //     cell.localPlayer.pause()
       // }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    }
   

}






