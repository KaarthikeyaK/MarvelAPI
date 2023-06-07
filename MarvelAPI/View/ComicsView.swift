//
//  ComicsView.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 04/06/23.
//

import SwiftUI

struct ComicsView: View {
        
    @EnvironmentObject var homeData: HomeViewViewModel
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                if homeData.fetchedComics.isEmpty{
                    ProgressView()
                        .padding(30)
                } else {
                    VStack(spacing: 15){
                        
                        ForEach(homeData.fetchedComics){ comic in
                            ComicsRowView(comic: comic)
                        }
                        
                        if homeData.offset == homeData.fetchedComics.count {
                            ProgressView()
                                .padding(.vertical)
                                .onAppear {
                                    print("Fetching New Data....")
                                    homeData.searchComic()
                                }
                        } else {
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !homeData.fetchedComics.isEmpty && minY < height {
                                    
                                    DispatchQueue.main.async {
                                        homeData.offset = homeData.fetchedComics.count
                                    }
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("Marvel Comics")
            .onAppear {
                    homeData.searchComic()
            }
        }
        
    }
}

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsView()
            .environmentObject(HomeViewViewModel())
    }
}
