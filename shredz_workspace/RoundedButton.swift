//
//  RoundedButton.swift
//  shredz_workspace
//
//  Created by Michael Alexander on 11/20/17.
//  Copyright © 2017 Michael Alexander. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
