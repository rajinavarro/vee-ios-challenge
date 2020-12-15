//
//  Comic.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 14/12/20.
//

import Foundation

struct Comic {
    var id: Int?
    var title: String?
    var thumbnail: String?
    
    init(args: [String:Any]?) {
        self.id = args?["id"] as? Int
        self.title = args?["title"] as? String
        self.thumbnail = (Thumbnail(args: args?["thumbnail"] as? [String : Any])).fullPath
    }
}
