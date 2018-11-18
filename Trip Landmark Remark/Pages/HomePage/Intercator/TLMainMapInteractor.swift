//
//  TLMainMapInteractor.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
//buid my service base on the network/ endpoint type protocol
protocol ServiceConnection {
    associatedtype Endpoint:EndPointType
    var enviroment:NetworkEnvironment{get}
    var router:Router<Endpoint>{get}
}
class TLMainMapInteractor:ServiceConnection {
    var enviroment: NetworkEnvironment = .production
    static let environment : NetworkEnvironment = .production
    let router = Router<TripNoteApi>()
    func getAllTripNote(_ completion: @escaping (_ movie: [TripNote]?,_ error: String?)->()) {
        router.request(.all(userId: 0)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = response.handleResponse()
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(ArrayWrapper<TripNote>.self, from: responseData)
                        completion(apiResponse.data,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
