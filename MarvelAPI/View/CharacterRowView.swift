//
//  CharacterRowView.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 07/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 15){
            
            WebImage(url: makeSecureURL(from: extractImage(data: character.thumbnail)))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(.title3)
                    .bold()
                Text(character.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .italic()
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 8) {
                    ForEach(character.urls, id: \.self){ url in
                        NavigationLink {
                            WebView(url: extractURL(data: url))
                                .navigationTitle(extractURLType(data: url))
                        } label: {
                            Text(extractURLType(data: url))
                        }

                    }
                    
                }
            }
            
            Spacer()
        }
        
    }
    
    func extractImage( data: [String: String]) -> URL {
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    func makeSecureURL(from url: URL) -> URL? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.scheme = "https"
        
        return components?.url
    }
    
    func extractURL(data: [String: String]) -> URL {
        let url = data["url"] ?? ""
        return URL(string: "\(url)")!
    }
    
    func extractURLType(data: [String: String]) -> String {
        let type = data["type"] ?? ""
        return type.capitalized
    }

}


struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: Character(id: 1, name: "Captain America", description: "A Kid From Brooklyn", thumbnail: ["img1" : "jpg"], urls: [["1" : "2"]]))
    }
}
