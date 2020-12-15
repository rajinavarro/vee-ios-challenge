//
//  CharacterDescriptionViewController.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 12/12/20.
//

import UIKit

private let contentViewCellIdentifier = "characterDescriptionContentCell"

private let comicsGalleryCellIdentifier = "comicsGalleryCell"


class CharacterDescriptionViewController: UIViewController{
    
    @IBOutlet weak var characterDescriptionTableView: UITableView!
    
    var character: Character?
    
    var comics: [Comic] = [Comic](){
        didSet{
            DispatchQueue.main.async {
                self.characterDescriptionTableView.reloadData()
            }
        }
    }
    
    lazy var characterComicsViewModel: CharacterComicsViewModel = {
        
        let obj = CharacterComicsViewModel()
        obj.delegate = self
        
        return obj
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomTableViewCell()
        fetchCharacterComics()
    }
    
    /// Carrega todos quadrinhos de um personagem.
    func fetchCharacterComics(){
        if let characterId = self.character?.id{
            
            self.characterComicsViewModel.getCharacterComics(characterId: characterId)
        }
    }
    
    /// Registra XIB das custom cell utilizadas
    func registerCustomTableViewCell(){
        
        characterDescriptionTableView.register(UINib(nibName: "CharacterDescriptionContentCell", bundle: nil), forCellReuseIdentifier: contentViewCellIdentifier)
        
        characterDescriptionTableView.register(UINib(nibName: "ComicsGalleryCell", bundle: nil), forCellReuseIdentifier: comicsGalleryCellIdentifier)
    }
    
    func setupDescriptionContentCell() -> UITableViewCell{
        
        if let contentCell = characterDescriptionTableView.dequeueReusableCell(withIdentifier: contentViewCellIdentifier) as? CharacterDescriptionContentCell,
           let character = self.character{
            
            contentCell.setupCell(character: character)
            
            return contentCell
        }
        return UITableViewCell()
    }
    
    func setupComicsGalleryCell() -> UITableViewCell{
        if let comicsCell = characterDescriptionTableView.dequeueReusableCell(withIdentifier: comicsGalleryCellIdentifier) as? ComicsGalleryCell,
           !comics.isEmpty{
            
            comicsCell.comics = comics
            
            return comicsCell
        }
        
        return UITableViewCell()
    }
}


// MARK: UITableViewDelegate & UITableViewDataSource
extension CharacterDescriptionViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return setupDescriptionContentCell()
        case 1:
            return setupComicsGalleryCell()
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: CharacterComicDelegate
extension CharacterDescriptionViewController: CharacterComicDelegate{
    func finishFetchCharacterComics(characterComics: [Comic]) {
        self.comics.append(contentsOf: characterComics)
    }
    
    func failFetchingCharacterComics(errorMessage: String) {
        print(errorMessage)
    }
}
