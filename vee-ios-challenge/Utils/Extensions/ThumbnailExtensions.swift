//
//  ThumbnailExtensions.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 11/12/20.
//

import Foundation
import UIKit

extension Thumbnail {

    /// Pega o link completo de uma Thumbnail.
    var fullPath: String? {

        if let imagePath = self.imagePath,
           let imageExtension = self.imageExtension {

            return imagePath + "." + imageExtension
        }

        return ""
    }
}
