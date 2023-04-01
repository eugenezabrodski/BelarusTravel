//
//  HotelsViewController.swift
//  BelarusTravel
//
//  Created by Eugene on 01/04/2023.
//

import UIKit
import WebKit

class HotelsViewController: UIViewController {
    
    var place: Place?
    
    var url = "https://101hotels.com/belarus/region/belovezhskaya_pushcha"
    
    let hotelView: WKWebView = {
        let hotelView = WKWebView()
        hotelView.translatesAutoresizingMaskIntoConstraints = false
        return hotelView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createConstraint()
        createView()
        hotelView.uiDelegate = self
    }
    
    private func createView() {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        self.hotelView.load(urlRequest)
        self.hotelView.allowsBackForwardNavigationGestures = true
    }
    
    private func createConstraint() {
        view.addSubview(hotelView)
        NSLayoutConstraint.activate([
            hotelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            hotelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            hotelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            hotelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    

}

extension HotelsViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
          webView.load(navigationAction.request)
        }
        return nil
      }
}


