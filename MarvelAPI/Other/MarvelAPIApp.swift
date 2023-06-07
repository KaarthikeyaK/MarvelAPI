//
//  MarvelAPIApp.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 04/06/23.
//

import SwiftUI

@main
struct MarvelAPIApp: App {
    
    init(){
        HomeViewViewModel().searchCharacter()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
