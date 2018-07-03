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

    let unwind = Constants.AuthUnwind
    var request: URLRequest? = nil
    var redirect: String? = nil
    
    var result: Result<URL> = Result.failure(AuthError.cancelled)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadRequest()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        result = Result.failure(AuthError.cancelled)
        performSegue(withIdentifier: unwind, sender: self)
    }

    //MARK: - Authorisation
    func loadRequest() {
        guard redirect != nil else {
            result = Result.failure(AuthError.redirectNil)
            performSegue(withIdentifier: unwind, sender: self)
            return
        }
        
        guard let authRequest = request else {
            result = Result.failure(AuthError.requestNil)
            performSegue(withIdentifier: unwind, sender: self)
            return
        }
        
        webView.load(authRequest)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            if url.begins(with: redirect!){
                result = Result.success(url)
                performSegue(withIdentifier: unwind, sender: self)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    //MARK: - Error Handling
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let statusCode = (navigationResponse.response as? HTTPURLResponse)?.statusCode else {
            decisionHandler(.allow)
            return
        }
        
        if statusCode >= 400 {
            result = Result.failure(AuthError.navigation(String(statusCode)))
            performSegue(withIdentifier: unwind, sender: self)
        }

         decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        result = Result.failure(AuthError.navigation(error.localizedDescription))
        performSegue(withIdentifier: unwind, sender: self)
    }
    
    //MARK: - Activity Indicator
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
