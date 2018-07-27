//
//  DistanceChooserTableViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 01/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class DistanceChooserTableViewController: UITableViewController, UISplitViewControllerDelegate {
    
    //TODO: Display custom cell that displays best overall time for that distance - where is this in the strava api? redesign model?
    lazy var distances: [Distance] = Distance.distances(upto: maxDistance)
    var runList = [Activity]()
    var maxDistance: Double {
        return runList.map{$0.distance}.max() ?? 0.0
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let btvc = secondaryViewController as? BestsTableViewController {
            if btvc.runs == nil {
                return true
            }
        }
        return false
    }

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
        //fetch runs? how to send off many requests? operations? how to know when finished? Should I use cell for row instead???
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return distances.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.distance, for: indexPath)
        cell.textLabel?.text = distances[indexPath.row].rawValue
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
