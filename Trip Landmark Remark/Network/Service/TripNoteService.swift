//
//  TripNoteService.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/24.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
import FirebaseDatabase
//buid my service base on the network/ endpoint type protocol
protocol ServiceConnection {
    associatedtype Endpoint:EndPointType
    var enviroment:NetworkEnvironment{get}
    var router:Router<Endpoint>{get}
}
struct TripNoteService:ServiceConnection {
    var enviroment: NetworkEnvironment = .production
    static let environment : NetworkEnvironment = .production
    let router = Router<TripNoteApi>()
    var ref: DatabaseReference = Database.database().reference()
//    private func getAllTripNote(_ completion: @escaping (_ movie: [TripNote]?,_ error: String?)->()) {
//        router.request(.all(userId: 0)) { (data, response, error) in
//            if error != nil {
//                completion(nil, "P]lease check your network connection.")
//            }
//            if let response = response as? HTTPURLResponse {
//                let result = response.handleResponse()
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue)
//                        return
//                    }
//                    do {
//                        print(responseData)
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        print(jsonData)
//                        let apiResponse = try JSONDecoder().decode(ArrayWrapper<TripNote>.self, from: responseData)
//                        completion(apiResponse.data,nil)
//                    }catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError)
//                }
//            }
//        }
//    }
    func getAllTripNote(_ completion: @escaping (_ note: [TripNote]?,_ error: String?)->()) {
        let userId = UserManager.shared.user?.userid
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            var allNotes:[TripNote] = [TripNote]()
            if let allNotesFromUser =  snapshot.value as? [String:Any] {
                for (_ , notesJSON) in allNotesFromUser {
                    if let notesJOSN = notesJSON as? [String:Any] {
                        for (_ , notes) in notesJOSN {
                            if let notes = notes as? [String:Any] {
                                let decoder = JSONDecoder.init()
                                if let data = try? JSONSerialization.data(withJSONObject: notesJOSN, options: JSONSerialization.WritingOptions(rawValue: 0)) {
                                    if let notes = try? decoder.decode(TripNote.self, from: data) {
                                        allNotes.append(notes)
                                    }
                                }
                            }
                        }
                    }
                }
                completion(allNotes,nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func postTripNote(_ note:TripNote) {
        guard let user = UserManager.shared.user, let userId = user.userid else {return}
        ref.child("users").child(userId).childByAutoId().setValue(["username": user.name ?? "", "latitude":note.latitude ?? "","longitude":note.longitude ?? "", "note":note.note ?? "","locationName":note.locationName ?? ""])
    }
}
