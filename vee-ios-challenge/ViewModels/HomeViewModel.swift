//
//  HomeViewModel.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func finishFetchCharacters(characters: [Result])
    func failFetchingCharacters(errorMessage: String)
}

class HomeViewModel{
    
    weak var delegate: HomeViewModelDelegate?
    
    func getHeroes(offset: Int = 50){
        
        let publicKey = APIKeys.publicKey.rawValue
        let ts = Date().currentTimeStamp
        let hash = ApiManager.shared.createAPIKey(ts: ts)
        
        let url = HeroesAPIURL.getHeroes.rawValue
        
        let requestURL = url + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&limit=50&offset=\(offset)"
        
        RequestsManager.shared.makeRequest(to: requestURL, method: .get) { [weak self] (data, error) in
            guard let data = data else { return }
            if error == nil{
                do {
                    let decoder = JSONDecoder()
                    if let response = try? decoder.decode(CharactersResponse.self, from: data){
                        let characters = response.data.results
                        if !characters.isEmpty{
                            self?.delegate?.finishFetchCharacters(characters: characters)
                        }else{
                            self?.delegate?.failFetchingCharacters(errorMessage: "Nenhum heroi encontrado, tente novamente!")
                        }
                    }
                }
            }else{
                self?.delegate?.failFetchingCharacters(errorMessage: error?.description ?? "Falha ao carregar herois")
            }
            
        }
    }
}
