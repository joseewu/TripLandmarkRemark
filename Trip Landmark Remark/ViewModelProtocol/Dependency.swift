//
//  Dependency.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/30.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation

protocol Dependency {
    associatedtype Dependency
    init(with Dependency:Dependency)
}
protocol ServerConnection:Dependency {
    associatedtype Service
    init(with service:Service)
}
protocol InjectParameter:Dependency {
    //InjectParameter that need to
}
