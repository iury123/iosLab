//
//  VideoTimelineControl.swift
//  MyLab
//
//  Created by Iury Miguel on 19/06/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

import UIKit

protocol VideoTimelineDelegate: class {
    func onSlideChanged(value: Float)
}

@IBDesignable class VideoTimelineSlider: UISlider {
    
    weak var delegate: VideoTimelineDelegate?
    
    @IBInspectable var minTrackColor: UIColor {
        get {
            return minimumTrackTintColor ?? .red
        }
        set {
            minimumTrackTintColor = newValue
        }
    }
    
    @IBInspectable var thumbColor: UIColor {
        get {
            return thumbTintColor ?? .red
        }
        set {
            thumbTintColor = newValue
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 7.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    //while we are here, why not change the image here as well? (bonus material)
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isContinuous = false
        self.minimumTrackTintColor = .red
        self.addTarget(self, action: #selector(VideoTimelineSlider.slideChange), for: .valueChanged)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoTimelineSlider.slideTapped))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func slideChange(sender: VideoTimelineSlider) {
        delegate?.onSlideChanged(value: sender.value)
    }
    
    @objc func slideTapped(gestureRecognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)
        let positionOfSlider: CGPoint = frame.origin
        let widthOfSlider: CGFloat = frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(maximumValue) / widthOfSlider)
        setValue(Float(newValue), animated: true)
        delegate?.onSlideChanged(value: Float(newValue))
    }
}
