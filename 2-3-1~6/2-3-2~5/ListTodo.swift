//
//  Department.swift
//  2-3-2~5
//
//  Created by 入江真礼 on 2019/10/11.
//  Copyright © 2019 入江真礼. All rights reserved.
//

import Foundation
import RealmSwift

class ListTodo: Object {
    @objc dynamic var todoID = NSUUID().uuidString
    @objc dynamic var todoTitle = ""
    @objc dynamic var todoContents = ""
    @objc dynamic var created = ""
    @objc dynamic var modified = ""
    @objc dynamic var limitDate = ""
    @objc dynamic var deleteFlg = false
    
    override static func primaryKey() -> String? {
        return "todoID"
    }
    override static func indexedProperties() ->
        [String] {
            return ["name"]
    }
}
