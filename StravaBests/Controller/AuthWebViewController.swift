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

    let unwind = Segues.AuthUnwind
    var request: URLRequest? = nil
    lazy var redirect: String? = request?.url?.getQueryValue(for: URLKeys.redirect)
    
    var result: Result<String> = Result.failure(AuthWebViewError.cancelled)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadRequest()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        result = Result.failure(AuthWebViewError.cancelled)
        performSegue(withIdentifier: unwind, sender: self)
    }

    //MARK: - Authorisation
    func loadRequest() {
        guard redirect != nil else {
            result = Result.failure(AuthWebViewError.redirectNil)
            performSegue(withIdentifier: unwind, sender: self)
            return
        }
        
        guard let authRequest = request else {
            result = Result.failure(AuthWebViewError.requestNil)
            performSegue(withIdentifier: unwind, sender: self)
            return
        }
        
        webView.load(authRequest)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            if url.begins(with: redirect!){
                if let code = url.getQueryValue(for: URLKeys.code){
                    result = Result.success(code)
                } else {
                    result = Result.failure(AuthWebViewError.callbackURLAuthCode)
                }
                decisionHandler(.cancel)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                performSegue(withIdentifier: unwind, sender: self)
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
            result = Result.failure(AuthWebViewError.navigation(String(statusCode)))
            performSegue(withIdentifier: unwind, sender: self)
        }
         decisionHandler(.allow)
    }
    
    //MARK: - Activity Indicator
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
