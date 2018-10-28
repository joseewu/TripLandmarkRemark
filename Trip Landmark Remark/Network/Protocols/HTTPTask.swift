//
//  HTTPTask.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/22.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String:String]
public enum HTTPTask {
    case request
    case requestWith(body:Parameters?,bodyEncoding:ParameterEncoding,url:Parameters?)
    case requestWithAdditionalHeader(body:Parameters?,bodyEncoding: ParameterEncoding,url:Parameters?, headers:HTTPHeaders?)
}
