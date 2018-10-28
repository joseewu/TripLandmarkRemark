//
//  ArrayWrapper.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/24.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation

struct ArrayWrapper<T:Codable>:Codable {
    internal enum CodingKeys:String, CodingKey {
        case data
    }
    let data:[T]?
}
extension ArrayWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode(Array<T>.self, forKey: .data)
    }
}
