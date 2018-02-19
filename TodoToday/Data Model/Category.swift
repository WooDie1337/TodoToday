//
//  Category.swift
//  TodoToday
//
//  Created by Daniel Krupenin on 19.02.2018.
//  Copyright © 2018 Daniel Krupenin. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}

