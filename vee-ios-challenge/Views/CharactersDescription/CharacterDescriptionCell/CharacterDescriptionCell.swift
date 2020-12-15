//
//  CharacterDescriptionCell.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 13/12/20.
//

import UIKit

class CharacterDescriptionCell: UITableViewCell {

    static let IDENTIFIER = "characterDescriptionCell"
    static let NIB_NAME = "CharacterDescriptionCell"

    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var lastModificationLB: UILabel!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var characterImageIV: UIImageView!
    
    var viewModel: CharacterDescriptionCellViewModel?{
        didSet{
            self.setupCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    /// Configura dados da CharacterDescriptionCell
    func setupCell() {

        setupCharacterImageIV()
        setupNameLB()
        setupLastModificationLB()
        setupDescriptionLB()
    }

    /// Configura nome do personagem na celula de descrição.
    func setupNameLB() {
        self.nameLB.text = viewModel?.setupNameLB()
    }

    /// Configura ultima modificação do personagem na celula de descrição.
    func setupLastModificationLB() {
        self.lastModificationLB.text = viewModel?.setupLastModificationLB()
    }

    /// Configura descrição do personagem na celula de descrição.
    func setupDescriptionLB() {
        self.descriptionLB.text = viewModel?.setupDescriptionLB()
    }

    /// Configura imagem do personagem na celula de descrição.
    func setupCharacterImageIV() {
        viewModel?.setupCharacterImageIV(characterImageIV: characterImageIV)
    }

}
