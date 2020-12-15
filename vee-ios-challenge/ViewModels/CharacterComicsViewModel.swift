//
//  CharacterDescriptionViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 13/12/20.
//

import Foundation


protocol CharacterComicDelegate: class{
    func finishFetchCharacterComics(characterComics: [Comic])
    func failFetchingCharacterComics(errorMessage: String)
}

class CharacterComicsViewModel{
    
    weak var delegate: CharacterComicDelegate?
    
    
    /// Carrega quadrinhos em que personagem aparece.
    func getCharacterComics(characterId: Int){
        
        let publicKey = APIKeys.publicKey.rawValue
        let ts = Date().currentTimeStamp
        let hash = ApiManager.shared.createAPIKey(ts: ts)
        
        let url = "\(CharactersAPIURL.getCharacters.rawValue)/\(characterId)/comics"
        
        let requestURL = url + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        RequestsManager.shared.makeRequest(to: requestURL, method: .get) { [weak self] (data, error) in
            
            guard let data = data else { return }
            
            if error == nil{
                do {
                    if let responseData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                       let responseDict = responseData as? [ String : Any ],
                       let dataDict = responseDict["data"] as? [ String : Any ],
                       let resultsDict = dataDict["results"] as? [ Any ]{
                        
                        self?.delegate?.finishFetchCharacterComics(characterComics: resultsDict.map{ Comic(args: $0 as? Dictionary<String, Any>) })
                        
                    }
                }
            }else{
                self?.delegate?.failFetchingCharacterComics(errorMessage: error?.description ?? "Failed to load character comics")
            }
            
        }
    }
}
