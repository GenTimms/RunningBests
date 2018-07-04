//
//  InitialViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 04/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    var account: APIAccount?
    var url: URL?

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.isHidden = true
        loginButton.isHidden = true
        loadAccount()
    }
    
    //MARK: - Authorization
    func loadAccount() {
    
        if let savedAccount = APIAccount.loadFromKeychain(Constants.Service)  {
            account = savedAccount
           statusLabel.isHidden = false
            return
        }
        
        loginButton.isHidden = false
    }
    
    @IBAction func login(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.AuthSegue, sender: self)
    }
    

    @IBAction func getAuthorizationResult(segue: UIStoryboardSegue) {
        let authWebView = segue.source as! AuthWebViewController
        let result = authWebView.result
        switch result {
        case .success(let accessCode): print("RESULT: \(accessCode)"); fetchToken(accessCode: accessCode, completion: {result in })
            
        case .failure(let error): print("RESULT: \(error)")
            //TODO: Display Error Notification
        }
    }
    
    func fetchToken(accessCode: String, completion: (Result<String>) -> Void) {
        if var request = Strava.token(code: accessCode).request {
            request.httpMethod = "POST"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("DATA \(data)")
                print("RESPONSE \(response)")
                print("ERROR \(error)")

                }
                
            }
        }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.AuthSegue {
            if let authVC = segue.destination.contents as? AuthWebViewController {
                authVC.redirect = StravaAPIConfig.Redirect_URI
                authVC.request = Strava.authorize.request
            }
        }
    }

    @IBAction func logOutUser(segue: UIStoryboardSegue) {
        try? account?.delete()
        account = nil
        loginButton.isHidden = false
    }


}
