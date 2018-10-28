//
//  ContentTableViewCell.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/24.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userInput: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor("#FFF5C6")
        selectionStyle = .none
    }
}
