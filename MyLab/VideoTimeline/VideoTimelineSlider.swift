//
//  VideoTimelineControl.swift
//  MyLab
//
//  Created by Iury Miguel on 19/06/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

import UIKit

protocol VideoTimelineDelegate: class {
    func onStopDragging(value: Float)
    func onDragging(value: Float)
}

@IBDesignable class VideoTimelineSlider: UISlider {
    
    weak var delegate: VideoTimelineDelegate?
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 8.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    //while we are here, why not change the image here as well? (bonus material)
    override func awakeFromNib() {
        super.awakeFromNib()
        minimumTrackTintColor = .red
        thumbTintColor = .red
        addTarget(self, action: #selector(VideoTimelineSlider.onDragging), for: .valueChanged)
        addTarget(self, action: #selector(VideoTimelineSlider.onStopDragging), for: .touchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoTimelineSlider.slideTapped))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func setValue(_ value: Float, animated: Bool) {
        super.setValue(value, animated: animated)
         delegate?.onDragging(value: value)
    }
    
    @objc func onStopDragging(sender: VideoTimelineSlider) {
        delegate?.onStopDragging(value: sender.value)
    }
    
    @objc func onDragging(sender: VideoTimelineSlider) {
        delegate?.onDragging(value: sender.value)
    }
    
    @objc func slideTapped(gestureRecognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)
        let positionOfSlider: CGPoint = frame.origin
        let widthOfSlider: CGFloat = frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(maximumValue) / widthOfSlider)
        value = Float(newValue)
        delegate?.onStopDragging(value: Float(newValue))
    }
}
