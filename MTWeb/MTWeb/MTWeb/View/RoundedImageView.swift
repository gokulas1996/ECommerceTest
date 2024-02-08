//
//  RoundedImageView.swift
//  MTWeb
//
//  Created by Gokul A S on 03/06/23.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        layer.cornerRadius = layer.frame.width / 2
    }
}
