//
//  ViewController.swift
//  stickySlider
//
//  Created by Jon Gilbert on 7/19/17.
//  Copyright © 2017 Jon Gilbert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var sliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValueLabel.text = "0.00"
    }

    @IBAction func sliderChanged(_ slider: PHStickySlider) {
        sliderValueLabel.text = "\(slider.value)"
    }
}

