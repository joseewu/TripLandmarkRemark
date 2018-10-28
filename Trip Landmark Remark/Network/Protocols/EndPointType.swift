//
//  EndPointType.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/22.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL:URL{get}
    var path:String{get}
    var httpMethod:HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }

}

public enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
