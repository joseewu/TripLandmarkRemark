//
//  TLUserNoteViewController.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/23.
//  Copyright © 2018 com.josee. All rights reserved.
//

import UIKit

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
    private var userNote:TripNote?
    internal var viewModel:TLUserNoteViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = TripNoteService()
        userNote = TripNote(locationName: nil, userId: nil, latitude: nil, longitude: nil, note: nil)
        userNote?.locationName = "fjisfj"
        let cellTypes:[TLUserNotePageCellType] = [.name(title: "Name", name: nil), .location(location: ("", "")),.note(title: "YourNote!", note: nil)]
        viewModel = TLUserNoteViewModel(with: service, cellTypes)
    }
    @IBAction func sendNote(_ sender: Any) {
//        viewModel.sendUserNote(TripNote(locationName: <#T##String?#>, userId: <#T##Int?#>, latitude: <#T##Double?#>, longitude: <#T##Double?#>, note: <#T##String?#>))
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
        case .name(let title, let name):
            let cell:ContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.name.text = title
            return cell
        case .note(let title, let _):
            let cell:UserInputTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.title.text = title
            return cell
        case .location(let location):
            let cell:ContentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.name.text = "where are you"
            cell.userInput.placeholder = "location.."
            return cell
        }
    }


}
