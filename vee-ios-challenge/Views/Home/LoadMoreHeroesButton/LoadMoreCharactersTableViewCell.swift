//
//  LoadMoreCharactersTableViewCell.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 11/12/20.
//

import UIKit
import AudioToolbox

protocol LoadMoreCharactersTableViewCellDelegate: class{
    
    func loadMoreCharacters()
}
class LoadMoreCharactersTableViewCell: UITableViewCell{
    
    weak var delegate: LoadMoreCharactersTableViewCellDelegate?
    
    @IBOutlet weak var loadMoreBT: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    /// Configura elementos da celula,
    func setupLoadMoreTableViewCell(){
        loadMoreBT.layer.masksToBounds = true
        loadMoreBT.layer.cornerRadius = 12
        loadMoreBT.addShadow(color: .black, opacity: 0.4, radius: 2)
    }
    
    @IBAction func loadMoreAction(_ sender: Any) {
        
        self.delegate?.loadMoreCharacters()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
}
