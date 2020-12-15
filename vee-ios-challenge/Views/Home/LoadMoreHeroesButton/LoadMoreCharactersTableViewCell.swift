//
//  LoadMoreCharactersTableViewCell.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 11/12/20.
//

import UIKit
import AudioToolbox

protocol LoadMoreCharactersTableViewCellDelegate: class {

    func loadMoreCharacters()
}

class LoadMoreCharactersTableViewCell: UITableViewCell {

    static let IDENTIFIER = "loadMoreCharactersCell"
    static let NIB_NAME = "LoadMoreCharactersTableViewCell"

    var delegate: LoadMoreCharactersTableViewCellDelegate?
    
    private var viewModel: LoadMoreCharactersTableViewCellViewModel = LoadMoreCharactersTableViewCellViewModel()

    @IBOutlet weak var loadMoreBT: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    /// Configura elementos da celula,
    func setupCell() {
        self.loadMoreBT = self.viewModel.setupLoadMoreBT(loadMoreBT: loadMoreBT)
    }

    /// Ação de carregar novos personagens.
    @IBAction func loadMoreAction(_ sender: Any) {
        self.delegate?.loadMoreCharacters()
    }

}
