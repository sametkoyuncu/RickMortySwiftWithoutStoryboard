//
//  RickMortyService.swift
//  RickMortySwiftWithoutStoryboard
//
//  Created by Samet Koyuncu on 21.10.2022.
//

import Alamofire

enum RickMortyServiceEndpoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickMortyService {
    func fetchAllData(response: @escaping ([Result]?) -> Void)
}

struct RickMortyService: IRickMortyService {
    func fetchAllData(response: @escaping ([Result]?) -> Void) {
        AF.request(RickMortyServiceEndpoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data =  model.value else {
                print(model.error?.localizedDescription ?? "error: fetchAllData process")
                response(nil)
                return
            }
            response(data.results)
            
        }
    }
}
  
