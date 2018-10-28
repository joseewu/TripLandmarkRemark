//
//  TLFloatButton.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/23.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit

class TLFloatButton: UIButton {
    open var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    open var iconImg: UIImage? {
        didSet {
            setImage(iconImg, for: .normal)
        }
    }
    open var iconTintColor: UIColor? {
        didSet {
            imageView?.tintColor = iconTintColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        renderUI()
    }
    private func renderUI() {
        let size = frame.size
        layer.cornerRadius = size.width/2
        clipsToBounds = true
    }
}
