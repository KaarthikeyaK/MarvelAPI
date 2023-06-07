//
//  CharactersView.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 04/06/23.
//

import SwiftUI

struct CharactersView: View {
    
    @EnvironmentObject var homeData: HomeViewViewModel
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    
                    if let characters = homeData.fetchedCharacters{
                        if characters.isEmpty{
                            Text("No Results Found.")
                                .padding(.top, 20)
                        } else {
                            ForEach(characters) { character in
                                Text(character.name)
                            }
                        }
                    } else {
                        if homeData.searchQuery != ""{
                            ProgressView()
                                .padding(.top, 20)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Marvel Characters")
        }
        .searchable(text: $homeData.searchQuery)
        .autocorrectionDisabled()
        .autocapitalization(.none)
        
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
            .environmentObject(HomeViewViewModel())
    }
}
