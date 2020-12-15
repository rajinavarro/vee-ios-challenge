//
//  Thumbnail.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 14/12/20.
//

import Foundation

struct Thumbnail {
    var imagePath: String?
    var imageExtension: String?

    init(args: [String:Any]?) {
        self.imagePath = args?["path"] as? String
        self.imageExtension = args?["extension"] as? String
    }
}
