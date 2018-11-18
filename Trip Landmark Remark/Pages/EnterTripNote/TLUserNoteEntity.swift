//
//  TLUserNoteEntity.swift
//  Trip Landmark Remark
//
//  Created by joseewu on 2018/11/18.
//  Copyright © 2018 com.josee. All rights reserved.
//

import Foundation
enum TLUserNotePageCellType {
    case name(title:String, name:String?)
    case note(title:String, note:String?)
    case location(location:(String,String))
}
