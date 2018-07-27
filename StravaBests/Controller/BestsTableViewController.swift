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
    var runs: [Run]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = BestsTableViewDataSource()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    

}
