//
//  UIPickerViewX.swift
//  DesignableXTesting
//
//  Created by Mark Moeykens on 2/22/17.
//  Copyright © 2017 Moeykens. All rights reserved.
//

import UIKit

class UIPickerViewX: UIPickerView {

    @IBInspectable var horizontal: Bool = false {
        didSet {
            updateView()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        updateView()
    }


    func updateView() {
        if horizontal {
            transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        } else {
            transform = .identity
        }
    }
}
