//
//  WebView.swift
//  MarvelAPI
//
//  Created by KAARTHIKEYA K on 07/06/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Placeholder
    }

}
