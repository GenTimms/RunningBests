//
//  InitialViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 04/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    var runList = [Activity]()
    var client: APIClient = StravaClient()
    var account: APIAccount? {
        didSet {
            if let newAccount = account {
               client.token = newAccount.accessToken
                client.fetchRunList { result in
                    switch result {
                    case.success(let runs): guard !runs.isEmpty else { print("No Runs"); return } //TODO: Display Error Notification
                    self.runList = runs
                    self.performSegue(withIdentifier: Segues.DistanceChooserSegue, sender: self)
                    case.failure(let error): print("Run List Fetch Failed, Error: \(error)")  //TODO: Display Error Notification
                    }
                }
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
        } else {
        displayLogin()
        }
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
        getToken(for: accessCode)
        case .failure(let error): print("Authorisation - User Log in/Access Code Failed: \(error)")
            //TODO: Display Error Notification
        }
    }
    
    func getToken(for accessCode: String) {
        client.fetchToken(accessCode: accessCode) { (result) in
            switch result {
            case .success(let token): self.createAccount(with: token)
            case .failure(let error): print("Authorisation - Token Fetch Failed: \(error)")
                //TODO: Display Error Notification
            }
        }
    }
    
    func createAccount(with token: String) {
        account = APIAccount(service: self.client.service, accessToken: token)
        do {
            try account?.save()
        }
        catch {
            print("Account Could not be saved to Keychain")
            //TODO: Display Error Notification
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.AuthSegue {
            if let authVC = segue.destination.contents as? AuthWebViewController {
                authVC.request =  client.oAuthRequest
            }
        }
        
        if segue.identifier == Segues.DistanceChooserSegue {
            if let splitVC = segue.destination.contents as? UISplitViewController {
                if let distancesVC = splitVC.viewControllers[0].contents as? DistanceChooserTableViewController {
                    distancesVC.runList = self.runList
                }
            }
        }
    }

    @IBAction func logOutUser(segue: UIStoryboardSegue) {
        try? account?.delete()
        account = nil
        displayLogin()
    }
}
