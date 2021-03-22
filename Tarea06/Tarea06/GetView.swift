//
//  GetView.swift
//  Tarea06
//
//  Created by Cristian Zuniga on 21/3/21.
//

import SwiftUI

struct PokemonDetailView: View {
    let name: String
    @ObservedObject var pkmVM = PokemonViewModel()
    
    var body: some View {
        VStack{
            HStack{
                if let imageURL = URL(string: self.pkmVM.pokemonDetails.sprites.front_default) {
                    Image(systemName: "square.fill").data(url: imageURL)
                        .frame(width: 150.0, height: 200.0)
                }
            }
            HStack{
                Text("Pokemon id: \(self.pkmVM.pokemonDetails.id)")
            }
            HStack{
                Text("Pokemon name: \(self.pkmVM.pokemonDetails.name.capitalizingFirstLetter())")
            }
            HStack{
                Text("Pokemon height: \(self.pkmVM.pokemonDetails.height)")
            }
            HStack{
                Text("Pokemon weight: \(self.pkmVM.pokemonDetails.weight)")
                    .onAppear{
                        self.pkmVM.fetchPokemonDetail(name: name)
                    }
            }
            
        }
    }
}

extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            guard let image = UIImage(data: data) else {
                return Image(systemName: "square.fill")
            }
            return Image(uiImage: image)
                .resizable()
        }
        return self
            .resizable()
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}



struct GetView: View {
    
    @ObservedObject var pkmVM = PokemonViewModel()
    @State var limit: String = ""
    @State var offset: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    Text("Get Request")
                        .font(.largeTitle)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 12, content:{
                            HStack{
                                Text("GET URL: https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=\(limit)")
                                    .font(.subheadline)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 150)
                            }})
                    
                    VStack(alignment: .leading, spacing: 12, content:{
                            HStack{
                                Text("offset")
                                    .font(.subheadline)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 150)
                                TextField("20", text: $offset)
                                    .autocapitalization(.none)
                            }})
                    
                    VStack{
                        HStack{
                            Text("limit")
                                .font(.subheadline)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                            TextField("20", text: $limit)
                                .autocapitalization(.none)
                        }
                    }
                    VStack{
                        HStack{
                            Button("Execute Get Request")
                            {
                                self.pkmVM.fetchPokemon(offset: offset,limit: limit)
                            }
                        }}
                    
                }
                HStack{
                    List(self.pkmVM.listOfPokemon){ pkm in
                        NavigationLink(destination: PokemonDetailView(name: pkm.name)) {
                            Text(String(pkm.name.capitalizingFirstLetter()))
                        }
                    }
                }
            }
        }
    }
}

struct GetView_Previews: PreviewProvider {
    static var previews: some View {
        GetView()
    }
}
