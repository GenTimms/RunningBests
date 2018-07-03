//
//  BestsTableViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 22/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class BestsTableViewController: UITableViewController {
    
    var distance = Distance.oneMile

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = BestsTableViewDataSource()
//        let authorization = Authorization(authorizationURL: Strava.authorize.url!, tokenURL: Strava.token.url!, callback: StravaAPIConfig.HostedRedirect)
//        authorization.getAuthToken { (result) in
//            switch result {
//            case.failure(let error): print("Authorization Failed With Error: \(error)")
//            case.success(let code): print("SUCCESS!!! 😁 Code = \(code)")
//            }
 //       }
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    

}
