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
 //model info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = logoutButton
        //already there due to nav controller?
    }
    
    lazy var logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.action = #selector(self.logout)
        button.title = "Log out"
        return button
    }()
    
    @objc func logout() {
     performSegue(withIdentifier: "logout", sender: self)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //prepare for segue to bests run list how is model communicated?
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
