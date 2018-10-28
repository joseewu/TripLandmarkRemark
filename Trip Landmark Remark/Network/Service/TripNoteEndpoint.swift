//
//  TripNoteEndpoint.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/24.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
enum NetworkEnvironment {
    case unitTest
    case production
}
public enum TripNoteApi {
    case all(userId:Int)
    case note(id:Int)
}
extension TripNoteApi: EndPointType {
    var environmentBaseURL : String {
        switch TripNoteService.environment {
        case .production: return "https://s3-ap-northeast-1.amazonaws.com/jstripnote/"
        default:
            return ""
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
        }

        var path: String {
            switch self {
            case .all(let _):
                return "AllTripNotes.json"
            default:
                return ""
            }
        }

        var httpMethod: HTTPMethod {
            return .get
        }

        var task: HTTPTask {
            switch self {
            case .all(let userId):
                return .requestWith(body: nil, bodyEncoding: .url, url: nil)
            default:
                return .requestWith(body: nil, bodyEncoding: .url, url: nil)
            }
        }

        var headers: HTTPHeaders? {
             return nil
        }


}
