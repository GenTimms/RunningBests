//
//  AuthWebViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 27/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import WebKit
import UIKit

class AuthWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        if let authRequest = Strava.authorize.request {
            webView.load(authRequest)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            let urlString = url.absoluteString
            let callback = urlString.components(separatedBy: "/?")
            if callback.first == StravaAPIConfig.Redirect_URI {
                self.dismiss(animated: true) {
                print("***CallbackURL Components***: \(url.absoluteString)")
                }
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
}
