//
//  UserInputTableViewCell.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/23.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit

class UserInputTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var note: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        renderUi()
    }
    private func renderUi() {
        backgroundColor = UIColor("#FFF5C6")
        selectionStyle = .none
        note.delegate = self
    }
}
extension UserInputTableViewCell:UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "input..." {
            textView.text = ""
        }
        return true
    }
}
