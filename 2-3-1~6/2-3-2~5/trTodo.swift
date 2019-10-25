//
//  Department.swift
//  2-3-2~5
//
//  Created by 入江真礼 on 2019/10/11.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import Foundation
import RealmSwift

class trTodo: Object {
    @objc dynamic var todoID : String = NSUUID().uuidString
    @objc dynamic var todoTitle : String = ""
    @objc dynamic var todoContents : String = ""
    @objc dynamic var created : String = ""
    @objc dynamic var modified : String = ""
    @objc dynamic var limitDate : String = ""
    @objc dynamic var deleteFlg : Bool = false
    
    override static func primaryKey() -> String? {
        return "todoID"
    }
    override static func indexedProperties() ->
        [String] {
            return ["name"]
    }
}
