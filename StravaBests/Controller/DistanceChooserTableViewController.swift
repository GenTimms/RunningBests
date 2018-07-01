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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.loginButton
        loadAccount()
    }
    
    //MARK: - Authorization
    lazy var loginButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.action = #selector(self.login)
        return button
    }()
    
    func loadAccount() {
        if let savedAccount = APIAccount.loadFromKeychain(Constants.Service) {
            account = savedAccount
            loginButton.title = "Log Out"
        } else {
            login()
        }
    }
    
    @objc func login() {
        performSegue(withIdentifier: Constants.AuthSegue, sender: self)
    }
    
    @IBAction func getAuthorizationResult(segue: UIStoryboardSegue) {
        let authWebView = segue.source as! AuthWebViewController
        let result = authWebView.result
        switch result {
            case .success(let url): print(url)
            case .failure(let error): print(error)
        }
    }
    //func exchangeCodeForAccessToken // should this be here? API Account?
        
        //TODO: - Error Handling - notification?
 
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return distances.count
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    



}
