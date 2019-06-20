//
//  VideoViewController.swift
//  MyLab
//
//  Created by Iury Miguel on 19/06/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet weak var maxTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var videoTimelineSlider: VideoTimelineSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTimelineSlider.delegate = self
        
        videoTimelineSlider.minimumValue = 0
        videoTimelineSlider.maximumValue = 10
        videoTimelineSlider.value = 0
        
        maxTimeLabel.text = String(Int(videoTimelineSlider.maximumValue))
       
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.videoTimelineSlider.value = self.videoTimelineSlider.value + 1
            if(self.videoTimelineSlider.value == 10) {
                timer.invalidate()
            }
        }
        
    }
    
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension VideoViewController: VideoTimelineDelegate {
    func onStopDragging(value: Float) {
        currentTimeLabel.text = String(Int(value))
        print("Soltou: \(value)")
    }
    func onDragging(value: Float) {
        currentTimeLabel.text = String(Int(value))
        print("Arrastando: \(value)")
    }
}
