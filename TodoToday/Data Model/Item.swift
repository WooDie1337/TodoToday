//
//  Item.swift
//  TodoToday
//
//  Created by Daniel Krupenin on 19.02.2018.
//  Copyright © 2018 Daniel Krupenin. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
