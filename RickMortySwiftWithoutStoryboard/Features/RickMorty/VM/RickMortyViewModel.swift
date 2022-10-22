//
//  RickMortyViewModel.swift
//  RickMortySwiftWithoutStoryboard
//
//  Created by Samet Koyuncu on 22.10.2022.
//

import Foundation

protocol IRickMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickMortyCharacters: [Result] { get set }
    var rickMortyService: IRickMortyService { get }
    
    var rickMortyOutput: RickMortyOutput? { get }
    
    func setDelegate(output: RickMortyOutput)
}

final class RickMortyViewModel: IRickMortyViewModel {
    var rickMortyOutput: RickMortyOutput?
    
    var rickMortyCharacters: [Result] = []
    let rickMortyService: IRickMortyService
    private var isLoading = false
    
    init() {
        self.rickMortyService = RickMortyService()
    }
    
    func setDelegate(output: RickMortyOutput) {
        rickMortyOutput = output
    }
    
    func fetchItems() {
        changeLoading()
        rickMortyService.fetchAllData { [weak self] (response) in
            guard let self = self else { return }
            
            self.rickMortyCharacters = response ?? []
            self.changeLoading()
            
            self.rickMortyOutput?.saveData(values: self.rickMortyCharacters)
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutput?.changeLoading(isLoad: isLoading)
    }
}
