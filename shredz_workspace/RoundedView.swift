//
//  RoundedView.swift
//  shredz_workspace
//
//  Created by Michael Alexander on 11/18/17.
//  Copyright © 2017 Michael Alexander. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }

}
