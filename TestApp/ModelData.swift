//
//  ModelData.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import Foundation
import SwiftyJSON

class ModelData {
    var userId : Int?
    var id: Int?
    var title: String?
    var body: String?

    static func with(json: JSON) -> ModelData? {
        let item = ModelData()

        if json["userId"].exists() && json["userId"] != "" {
            item.userId = json["userId"].int
        }
        if json["id"].exists() && json["id"] != "" {
            item.id = json["id"].int
        }
        if json["title"].exists() && json["title"] != "" {
            item.title = json["title"].string
        }
        if json["body"].exists() && json["body"] != "" {
            item.body = json["body"].string
        }

        return item
    }
}

