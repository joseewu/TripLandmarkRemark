//
//  Bindings.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/10/30.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation

protocol Bindings {
    associatedtype Input
    associatedtype Output
    var output:Output! {get set}
    func bind(with input:Input)
}
