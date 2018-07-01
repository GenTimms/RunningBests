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
    var result: Result<URL,APIError> = Result.failure(APIError.authorizationCancelled)
    
    //TODO: - Cancel / Go Back Buttons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        if let authRequest = Strava.authorize.request {
            webView.load(authRequest)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            if url.contains(string: StravaAPIConfig.Redirect_URI){
                self.presentingViewController!.dismiss(animated: true) {

                }
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
}
