//
//  InitialViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 04/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    var client: APIClient = StavaClient()
    var account: APIAccount? {
        didSet {
            if let newAccount = account {
               client.token = newAccount.accessToken
               //client.fetchRuns()
            }
        }
    }

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            loadAccount()
    }
    
    func displayStatus() {
        statusLabel.isHidden = false
        loginButton.isHidden = true
    }
    
    func displayLogin() {
        statusLabel.isHidden = true
        loginButton.isHidden = false
    }
    
    //MARK: - Authorization
    func loadAccount() {
        if let savedAccount = APIAccount.loadFromKeychain(client.service)  {
            account = savedAccount
            displayStatus()
            return
        }
        displayLogin()
    }
    
    @IBAction func login(_ sender: UIButton) {
        performSegue(withIdentifier: Segues.AuthSegue, sender: self)
    }

    @IBAction func getAuthorizationResult(segue: UIStoryboardSegue) {
        let authWebView = segue.source as! AuthWebViewController
        let result = authWebView.result
        switch result {
        case .success(let accessCode): print("RESULT: \(accessCode)");
        displayStatus()
        createAccount(accessCode: accessCode)
        case .failure(let error): print("Authorisation - User Log in/Access Code Failed: \(error)")
            //TODO: Display Error Notification
        }
    }
    
    func createAccount(accessCode: String) {
       client.fetchToken(accessCode: accessCode) { (result) in
            switch result {
            case .success(let token): self.account = APIAccount(service: self.client.service, accessToken: token)
            case .failure(let error): print("Authorisation - Token Fetch Failed: \(error)")
                //TODO: Handle For User - Notification
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.AuthSegue {
            if let authVC = segue.destination.contents as? AuthWebViewController {
                authVC.request = Strava.authorize.request
            }
        }
    }

    @IBAction func logOutUser(segue: UIStoryboardSegue) {
        try? account?.delete()
        account = nil
        displayLogin()
    }
}
