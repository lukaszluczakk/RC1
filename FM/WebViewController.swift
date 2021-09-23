//
//  WebViewController.swift
//  FM
//
//  Created by Łukasz Łuczak on 05/09/2021.
//

import Foundation
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    var dataItem: DataItemDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
}

extension WebViewController: WKUIDelegate {
    func configureWebView() {
        webView.accessibilityIdentifier = "WebView"
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        webView.contentMode = .center
        
        guard
            let urlString = dataItem?.imageURL,
            let url = URL(string: urlString) else {
            return
        }
        
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
}
