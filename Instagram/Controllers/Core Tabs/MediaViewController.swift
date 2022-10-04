//
//  MediaViewController.swift
//  Instagram
//
//  Created by Lộc Xuân  on 14/09/2022.
//

import UIKit
import AVFoundation

class MediaViewController: UIViewController {

    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBarItem.title = "Notification"

    }
    
    private func didTapTakePicture(){
        
    }
    
}


