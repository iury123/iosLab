//
//  VideoViewController.swift
//  MyLab
//
//  Created by Iury Miguel on 19/06/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet weak var videoTimelineSlider: VideoTimelineSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTimelineSlider.delegate = self
        
        videoTimelineSlider.minimumValue = 0
        videoTimelineSlider.maximumValue = 10
        videoTimelineSlider.value = 7
    }
    
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension VideoViewController: VideoTimelineDelegate {
    func onStopDragging(value: Float) {
        print("Soltou: \(value)")
    }
    func onDragging(value: Float) {
        print("Arrastando: \(value)")
    }
}
