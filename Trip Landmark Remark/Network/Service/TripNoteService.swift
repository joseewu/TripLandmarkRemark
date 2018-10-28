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
struct TripNoteService {
    static let environment : NetworkEnvironment = .production
    let router = Router<TripNoteApi>()
    var ref: DatabaseReference = Database.database().reference()
//    private func getAllTripNote(_ completion: @escaping (_ movie: [TripNote]?,_ error: String?)->()) {
//        router.request(.all(userId: 0)) { (data, response, error) in
//            if error != nil {
//                completion(nil, "Please check your network connection.")
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
    func getAllTripNote(_ completion: @escaping (_ movie: [TripNote]?,_ error: String?)->()) {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.key)
            if let value =  snapshot.value as? [String:Any] {
                print("value")

            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func postTripNote() {
        guard let user = UserManager.shared.user, let userId = user.userid else {return}
        ref.child("users").child(userId).childByAutoId().setValue(["username": user.name, "latitude":20,"longitude":135, "note":"beautiful","locationName":"scene1"])
    }
}
