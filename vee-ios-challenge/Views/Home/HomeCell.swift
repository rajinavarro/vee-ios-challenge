//
//  HomeCollectionViewCell.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import UIKit

protocol HomeCellDelegate: class {

    func moreInfoAction(character: Character)
}

class HomeCell: UITableViewCell {

    static let IDENTIFIER = "homeCell"
    static let NIB_NAME = "HomeCell"

    @IBOutlet weak var characterImageIV: UIImageView!
    @IBOutlet weak var characterNameLB: UILabel!
    @IBOutlet weak var characterDescriptionLB: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var moreInfoBT: UIButton!
    @IBOutlet weak var lastModificationLB: UILabel!


    weak var delegate: HomeCellDelegate?
    
    var viewModel: HomeCellViewModel?

    override class func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    /// Configura elementos da celula
    func setupCell() {

        setupCellView()
        setupMoreInfoButton()
        setupCharacterImage()
        setupCharacterDescriptionLB()
        setupCharacterNameLB()
        setupLastModificationLB()
    }

    /// Configura celula de fundo da tela Home.
    func setupCellView() {
        cellView = self.viewModel?.setupCellView(cellView: cellView)
    }

    /// Configura botão de mais informações sobre o personagem.
    func setupMoreInfoButton() {
        moreInfoBT = self.viewModel?.setupMoreInfoButton(moreInfoBT: moreInfoBT)
    }

    /// Configura imagem do personagem.
    func setupCharacterImage() {
        characterImageIV = self.viewModel?.setupCharacterImage(characterImageIV: characterImageIV)
    }

    /// Configura descrição do personagem.
    func setupCharacterDescriptionLB() {
        characterDescriptionLB.text = self.viewModel?.setupCharacterDescriptionLB()
    }

    /// Configura nome do personagem.
    func setupCharacterNameLB() {
        characterNameLB.text = self.viewModel?.setupCharacterNameLB()
    }

    /// Configura ultimo modificação do personagem.
    func setupLastModificationLB() {
        self.lastModificationLB.text = self.viewModel?.setupLastModificationLB()
    }

    /// Ação de novos personagens.
    @IBAction func moreInfoAction(_ sender: Any) {
    
        if let viewModel = viewModel {
            viewModel.getCharacter{ character in
                self.delegate?.moreInfoAction(character: character)
            }
        }
    }
}
