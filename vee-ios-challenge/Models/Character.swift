//
//  Character.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import Foundation

struct Character {
    var id: Int?
    var name: String?
    var description: String?
    var modifiedDate: String?
    var thumbnail: String?
    
    init(args: Dictionary<String, Any>?) {
        self.id = args?["id"] as? Int
        self.name = args?["name"] as? String
        self.modifiedDate = args?["modified"] as? String
        self.thumbnail = (Thumbnail(args: args?["thumbnail"] as? [String : Any])).fullPath
        self.description = args?["description"] as? String

    }
}
