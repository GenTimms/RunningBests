//
//  InitialViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 04/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    //MARK: - Views
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var failedFetchStackView: UIStackView!
    
    private func updateStatus(login: Bool, animating: Bool, message: String?) {
        
        failedFetchStackView.isHidden = true
        loginButton.isHidden = !login
        statusLabel.isHidden = login
        
        statusLabel.text = message != nil  ? message : ""
        
        if animating {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func showRetryStackView() {
        loginButton.isHidden = true
        statusLabel.isHidden = true
        activityIndicator.stopAnimating()
        failedFetchStackView.isHidden = false
    }
    
    private func displayErrorNotification(description: String, error: Error?) {
        let details = description + " " + ((error?.localizedDescription) ?? "")
        print(details)
        //TODO: Display Notification
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAccount()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        updateStatus(login: true, animating: false, message: "")
    }
    
    //MARK: - Authorization
    var account: APIAccount? {
        didSet {
            if let newAccount = account {
                print("TOKEN: \(newAccount.accessToken)")
                client.token = newAccount.accessToken
                fetchRuns()
            } else {
                client.token = nil
                updateStatus(login: true, animating: false, message: nil)
            }
        }
    }

    private func loadAccount() {
        if let savedAccount = APIAccount.loadFromKeychain(client.service)  {
            account = savedAccount
        } else {
            account = nil
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        performSegue(withIdentifier: Segues.AuthSegue, sender: self)
    }

    //Unwind Segue
    @IBAction func getAuthorizationResult(segue: UIStoryboardSegue) {
        let authWebView = segue.source as! AuthWebViewController
        let result = authWebView.result
        switch result {
        case .success(let accessCode): getToken(for: accessCode)
        case .failure(let error): displayErrorNotification(description: "Authorization: Webview", error: error)
        }
    }
    
    private func getToken(for accessCode: String) {
        updateStatus(login: false, animating: true, message: "Authorizing...")
        client.fetchToken(accessCode: accessCode) { (result) in
            switch result {
            case .success(let token): self.createAccount(with: token)
            case .failure(let error): self.displayErrorNotification(description: "Authorization: Token exchange", error: error)
            }
        }
    }
    
    private func createAccount(with token: String) {
        account = APIAccount(service: self.client.service, accessToken: token)
        do {
            try account?.save()
        }
        catch {
            displayErrorNotification(description: "Saving Account to Keychain", error: error)
        }
    }
    
    //Button
    @IBAction func logOut(_ sender: Any) {
        logout()
    }
    
    //Unwind Segue
    @IBAction func logOutUser(segue: UIStoryboardSegue) {
        logout()
    }
    
    private func logout() {
        deauthorise()
        try? account?.delete()
        account = nil
    }
    
    private func deauthorise() {
        client.deauthorize { result in
            switch result {
            case .failure(let error): self.displayErrorNotification(description: "Deauthorization failed", error: error)
            case .success(let token): print("Successfully deauthorised for \(token)")
            }
        }
    }
    
    //MARK: - Fetching
    var runs: Runs?
    var client: APIClient = StravaClient()
    
    @IBAction func retryFetch(_ sender: Any) {
        fetchRuns()
    }
    
    private func fetchRuns() {
        updateStatus(login: false, animating: true, message: "Fetching Runs...")
        client.fetchRuns() { result in
            switch result {
            case.success(let fetchedRuns): self.runs = fetchedRuns; self.performSegue(withIdentifier: Segues.DistanceChooserSegue, sender: self)
            case.failure(let error):
                self.displayErrorNotification(description: "Fetching Runs", error: error)
                self.showRetryStackView()
            }
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.AuthSegue {
            if let authVC = segue.destination.contents as? AuthWebViewController {
                authVC.request =  client.oAuthRequest
            }
        }
        
        if segue.identifier == Segues.DistanceChooserSegue {
            if let splitVC = segue.destination.contents as? UISplitViewController {
                if let distancesVC = splitVC.viewControllers[0].contents as? DistanceChooserTableViewController, let fetchedRuns = runs {
                    distancesVC.runs = fetchedRuns                }
            }
        }
    }
}
