//
//  PHStickySlider.swift
//  stickySlider
//
//  Created by Jon Gilbert on 7/19/17.
//  Copyright © 2017 Jon Gilbert. MIT Licence.
//
//  Now the slider "locks in place" if the user keeps their finger stationary for a second or two.
//  This prevents the dreaded "it changed when I lifted my finger" issue.
//  If Settings > Sounds > System Haptics is turned on in iOS 10, the user will also get a lil vibration
//  when the "lock in place" occurs.

import UIKit

class PHStickySlider: UISlider {
    var timeLastUpdated:TimeInterval = -1.0
    var lastValue:Float = -1.0
    var shouldVibrateOnLock = true
    var didVibrate = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.addTarget(self, action: #selector(reset), for: [.touchUpInside,.touchUpOutside])
    }
    
    @objc private func reset() {
        timeLastUpdated = -1.0
        didVibrate = false
    }
    
    override open func setValue(_ value: Float, animated: Bool) {
        if(timeLastUpdated < -0.1) {
            timeLastUpdated = Date().timeIntervalSince1970
        }
        else {
            let now:Double = Date().timeIntervalSince1970
            let delta:Double = now - timeLastUpdated
            if(delta > 1.0) {
                if #available(iOS 10.0, *) {
                    if(shouldVibrateOnLock == true && didVibrate == false) {
                        let generator = UIImpactFeedbackGenerator(style: .heavy)
                        generator.impactOccurred()
                        didVibrate = true
                    }
                }
                super.setValue(lastValue, animated: false)
                return
            }
        }
        if(lastValue == value) {
            return
        }
        timeLastUpdated = Date().timeIntervalSince1970
        lastValue = value
        super.setValue(value, animated: true)
    }
    
}
