//
//  TLUserNoteViewController.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/23.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit
import CoreLocation

class TLUserNoteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "UserInputTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInputTableViewCell")
            tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
            tableView.backgroundColor = UIColor.clear
            tableView.separatorStyle = .none
            tableView.estimatedRowHeight = 100
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var sendButton: UIButton!
    internal var assitantView:UIView = UIView()
    internal var userNote:TripNote?
    internal var viewModel:TLUserNoteViewModel!
    public var currentLocation:CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        assitantView.backgroundColor = UIColor.clear
        assitantView.frame = view.frame
        assitantView.isHidden = true
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TLUserNoteViewController.didEndEditing))
        assitantView.addGestureRecognizer(tapGesture)
        view.addSubview(assitantView)
        sendButton.layer.cornerRadius = 6
        sendButton.clipsToBounds = true
        let service = TripNoteService()
        userNote = TripNote(locationName: nil, userId: nil, latitude: currentLocation?.latitude, longitude: currentLocation?.longitude, note: nil)
        let cellTypes:[TLUserNotePageCellType] = [.name(title: "Name", name: "ocation"), .location(location: ("\(currentLocation?.latitude ?? 0)", "\(currentLocation?.longitude ?? 0)")),.note(title: "YourNote!", note: nil)]
        viewModel = TLUserNoteViewModel(with: service, cellTypes)
    }
    @objc private func didEndEditing() {
        assitantView.isHidden = true
        view.endEditing(true)
    }
    @IBAction func sendNote(_ sender: Any) {
        guard let userNote = userNote else {return}
        viewModel.sendUserNote(userNote)
        navigationController?.popViewController(animated: true)
    }

}
extension TLUserNoteViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellTypes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = viewModel.cellTypes?[indexPath.row] else {
            let cell:UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.backgroundColor = UIColor.clear
            return cell
        }
        switch cellType {
        case .name(let _, let name):
            let cell:ContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.name.text = "where are you"
            cell.name.tag = indexPath.row
            cell.userInput.delegate = self
            return cell
        case .note(let title, let _):
            let cell:UserInputTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.note.delegate = self
            cell.title.text = title
            return cell
        case .location(let location):
            let cell:ContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.name.text = "where are you"
            cell.userInput.delegate = self
            cell.userInput.placeholder = "location.."
            cell.userInput.tag = indexPath.row
            cell.userInput.text = "\(location.0),\(location.1)"
            return cell
        }
    }
}
extension TLUserNoteViewController:UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        userNote?.note = textView.text

    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        assitantView.isHidden = false
        if textView.text == "input..." {
            textView.text = ""
        }
        return true
    }
}
extension TLUserNoteViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        assitantView.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            break
        case 0:
            userNote?.locationName = textField.text
        default:
            break
        }
    }
}
