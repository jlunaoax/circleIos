//
//  UIImageView+CircularImage.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 14/06/23.
//

import UIKit

extension UIImageView {
    func setCircularImageView() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
