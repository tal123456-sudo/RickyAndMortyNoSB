//
//  RickyMortieViewModel.swift
//  RickyMortyWithoutSB
//
//  Created by Muhammet  on 12.06.2022.
//

import Foundation

protocol IRickyMortyViewModel {
    
    func fetchItems()
    func changeLoading()
    
    var rickyMortysCharacters: [Result] { get set }
    var rickyMortyService: IRickAndMortyService {get}
    
    var rickyMortyOutput: RickyMortyOutput? {get}
    
    func setDelegate(output: RickyMortyOutput)
}

final class RickyMortyViewModel:IRickyMortyViewModel {
    
    var rickyMortyOutput: RickyMortyOutput?
    
    func setDelegate(output: RickyMortyOutput) {
        self.rickyMortyOutput = output
        
    }
    
    
  
    var rickyMortysCharacters: [Result] = []
    private var isLoading = false
    let rickyMortyService: IRickAndMortyService
    init() {
        rickyMortyService = RickAndMortyService()
    }
    
    
    func fetchItems() {
        changeLoading()
            self.rickyMortyService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickyMortysCharacters = response ?? []
            self?.rickyMortyOutput?.saveDatas(values: self?.rickyMortysCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickyMortyOutput?.changeLoading(isLoad: isLoading)
    }
    
    
    
}
