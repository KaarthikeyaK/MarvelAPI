//
//  ComicsRowVIew.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 07/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicsRowView: View {
    
    var comic: Comic
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
                if let imageUrl = makeSecureURL(from: extractImage(data: comic.thumbnail)) {
                    WebImage(url: imageUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding(.leading)
                } else {
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 5) {
                    Text(String(comic.issueNumber))
                        .bold()
                        .italic()
                        .font(.body)
                    Text(comic.title)
                        .font(.subheadline)
                        .bold()
                }
                if let description = comic.description{
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .italic()
                        .multilineTextAlignment(.leading)
                } else {
                    Text("No Description Found")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .italic()
                }
                
                HStack(spacing: 8) {
                    ForEach(comic.urls, id: \.self){ url in
                        NavigationLink {
                            WebView(url: extractURL(data: url))
                                .navigationTitle(extractURLType(data: url))
                        } label: {
                            Text(extractURLType(data: url))
                                .font(.system(size: 10))
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

