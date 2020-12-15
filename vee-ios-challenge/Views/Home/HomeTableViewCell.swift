//
//  HomeCollectionViewCell.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import UIKit

protocol HomeTableViewCellDelegate: class {

    func moreInfoAction(character: Character)

}

class HomeTableViewCell: UITableViewCell {

    static let IDENTIFIER = "homeCell"
    static let NIB_NAME = "HomeTableViewCell"

    @IBOutlet weak var characterImageIV: UIImageView!
    @IBOutlet weak var characterNameLB: UILabel!
    @IBOutlet weak var characterDescriptionLB: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var moreInfoBT: UIButton!
    @IBOutlet weak var lastModificationLB: UILabel!

    var character: Character?

    weak var delegate: HomeTableViewCellDelegate?

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    /// Configura elementos da celula
    func setupCell(character: Character) {

        self.character = character

        setupCellView()
        setupMoreInfoButton()
        setupCharacterImage()
        setupCharacterDescription()
        setupCharacterName()
        setupLastModificationLB()
    }

    func setupCellView() {
        cellView.layer.cornerRadius = 12
        cellView.addShadow(color: .black, opacity: 0.4, radius: 12)
    }

    func setupMoreInfoButton() {
        moreInfoBT.layer.cornerRadius = moreInfoBT.frame.height / 2
        moreInfoBT.addShadow(color: .black, opacity: 0.4, radius: 2)
    }

    func setupCharacterImage() {
        self.characterImageIV.roundCorners(.topLeft, radius: 12)
        self.characterImageIV.downloadImage(from: self.character?.thumbnail)
    }

    func setupCharacterDescription() {
        if let characterDescription = self.character?.description {
            self.characterDescriptionLB.text = characterDescription.isEmpty ? EmptyStateString.emptyDescription.rawValue : self.character?.description
        }
    }

    func setupCharacterName() {
        characterNameLB.text = self.character?.name
    }

    func setupLastModificationLB() {
        if let lastModification = self.character?.modifiedDate?.dateFormattedToString {
            lastModificationLB.text = "Last modification: \(lastModification)"
        }
    }

    @IBAction func moreInfoAction(_ sender: Any) {
        if let character = self.character {
            self.delegate?.moreInfoAction(character: character)
        }
    }
}
