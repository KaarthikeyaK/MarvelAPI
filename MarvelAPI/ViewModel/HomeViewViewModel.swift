//
//  HomeViewViewModel.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 04/06/23.
//

import Foundation
import SwiftUI
import CryptoKit
import Combine

class HomeViewViewModel: ObservableObject{
    
    let publicKey = "f81073107fae779015c64eea4b7db0c4"
    let privateKey = "189941497904b0d736e9ab1dc1012d4a113d6acb"
    
    @Published var searchQuery = ""
    @Published var fetchedCharacters: [Character]? = nil
    @Published var fetchedComics: [Comic] = []
    @Published var offset: Int = 0
    
    var searchCancellable: AnyCancellable? = nil
    
    init(){
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] str in
                if str == "" {
                    // Reset Data
                    self?.fetchedCharacters = nil
                    
                } else {
                    self?.fetchedCharacters = nil
                    self?.searchCharacter()
                }
            })
    }
    
    func searchComic(){
        let ts = String(Date().timeIntervalSince1970)
        let hash = self.md5("\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else {
                print("No Data Found")
                return
            }
            
            do {
                let comics = try JSONDecoder().decode(APIComicResult.self, from: APIData)
                DispatchQueue.main.async {
                    self.fetchedComics.append(contentsOf: comics.data.results)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func searchCharacter(){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = self.md5("\(ts)\(privateKey)\(publicKey)")
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url = "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, error in
            if let error = error{
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let APIData = data else {
                print("No Data found")
                return
            }
            
            do{
                // Decoding the API Data
                let characters = try JSONDecoder().decode(APIResult.self, from: APIData)
                DispatchQueue.main.async {
                    if self.fetchedCharacters == nil {
                        self.fetchedCharacters = characters.data.results
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()

    }
    
    func md5(_ string: String) -> String {
        let inputData = Data(string.utf8)
        let hashedData = Insecure.MD5.hash(data: inputData)
        let hashString = hashedData.map { String(format: "%02hhx", $0) }.joined()
        return hashString
    }
    
}
