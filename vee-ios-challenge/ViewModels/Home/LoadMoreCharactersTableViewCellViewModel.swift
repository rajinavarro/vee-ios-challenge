//
//  LoadMoreCharactersTableViewCellViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 15/12/20.
//

import Foundation
import UIKit

class LoadMoreCharactersTableViewCellViewModel{
    
    /// Configura botão de carregar mais ao fim da tela Home.
    func setupLoadMoreBT(loadMoreBT: UIButton) -> UIButton{
        loadMoreBT.layer.masksToBounds = true
        loadMoreBT.layer.cornerRadius = 12
        loadMoreBT.addShadow(color: .black, opacity: 0.4, radius: 2)
        
        return loadMoreBT
    }
    
}
