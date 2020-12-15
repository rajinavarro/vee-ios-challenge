//
//  UIImageVIewExtensions.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import UIKit
import SDWebImage

extension UIImageView {

    /// Baixa imagens utilizando um link no formato de String.
    func downloadImage(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {

        if let link = link,
           let url = URL(string: link) {

            self.sd_setImage(with: url, placeholderImage: nil, options: .progressiveDownload, progress: nil, completed: nil)
        }
    }
}
