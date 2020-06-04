//
//  MovieWebViewController.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/31/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import UIKit
import WebKit

class MovieWebViewController: UIViewController, WKNavigationDelegate {
    
    var webView : WKWebView!
    var url : String?
    var activityIndicator = UIActivityIndicatorView()
   
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        if let url = URL(string: url ?? "https://yts.mx/"){
        let request = URLRequest(url: url)
        webView.load(request)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    

  

}
