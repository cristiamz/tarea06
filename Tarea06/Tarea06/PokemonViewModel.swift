//
//  PokemonViewModel.swift
//  Tarea06
//
//  Created by Cristian Zuniga on 21/3/21.
//

import SwiftUI

class PokemonViewModel: ObservableObject {
    
    @Published var listOfPokemon: [PokemonTCG.Pokemon] = []
    @Published var pokemonDetails: PokemonDetail = .init(id:0, name:"", height:0, weight: 0, sprites: .init(front_default:""))
    
    func fetchPokemon(offset: String, limit: String){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=\(limit)") else {
            print("Your API end point is Invalid")
            return
        }
        let request = URLRequest(url: url)
        // The shared singleton session object.
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = try? JSONDecoder().decode(PokemonTCG.self, from: data) {
                    DispatchQueue.main.async {
                        self.listOfPokemon = response.results
                    }
                    return
                }
            }
            
        }.resume()
    }
    
    func fetchPokemonDetail(name: String){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)") else {
            print("Your API end point is Invalid")
            return
        }
        let request = URLRequest(url: url)
        // The shared singleton session object.
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = try? JSONDecoder().decode(PokemonDetail.self, from: data) {
                    DispatchQueue.main.async {
                        self.pokemonDetails = response
                    }
                    return
                }
            }
            
        }.resume()
    }
}

