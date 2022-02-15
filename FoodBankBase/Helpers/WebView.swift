//
//  WebView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/24/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL?

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        return WKWebView(frame: .zero, configuration: config)
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

        guard let myURL = url else {
            return
        }

        let request = URLRequest(url: myURL)
        uiView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "www.google.com"))
    }
}
