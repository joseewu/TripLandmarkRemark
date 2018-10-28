//
//  User.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/22.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
struct User:Codable {
    internal enum CodingKeys:String,CodingKey {
        case id
        case name
    }
    let name:String?
    let userid:String?
    var currentLocation:(String?,String?)?
}
extension User {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        userid = try container.decode(String.self, forKey: .id)
        currentLocation = (nil, nil)
    }
    func encode(to encoder: Encoder) throws {

    }
}
