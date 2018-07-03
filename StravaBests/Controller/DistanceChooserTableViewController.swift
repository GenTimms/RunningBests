//
//  DistanceChooserTableViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 01/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class DistanceChooserTableViewController: UITableViewController {
    
    var distances: [Distance] = Distance.All
    var account: APIAccount?
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.loginButton
        loadAccount()
    }
    
    //MARK: - Authorization
    lazy var loginButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.target = self
        button.action = #selector(login)
        return button
    }()
    
    func loadAccount() {
        if let savedAccount = APIAccount.loadFromKeychain(Constants.Service) {
            account = savedAccount
            loginButton.title = "Log Out"
        } else {
            loginButton.title = "Log In"
        }
    }
    
    @objc func login() {
        performSegue(withIdentifier: Constants.AuthSegue, sender: self)
    }
    
    @IBAction func getAuthorizationResult(segue: UIStoryboardSegue) {
        let authWebView = segue.source as! AuthWebViewController
        let result = authWebView.result
        switch result {
        case .success(let accessCodeURL):print ("RESULT: \(accessCodeURL)")
            //account = APIAccount.createAccount(from: Constants.Service, with: accessCodeURL)
        case .failure(let error): print("RESULT: \(error)") //Display authentication failed notification retry option?
        }
    }
    //func exchangeCodeForAccessToken // should this be here? API Account?
        
        //TODO:  Error Handling - notification?
 
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.AuthSegue {
            if let authVC = segue.destination.contents as? AuthWebViewController {
                authVC.redirect = StravaAPIConfig.Redirect_URI
                authVC.request = Strava.authorize.request
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return distances.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return UITableViewCell()
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    



}
