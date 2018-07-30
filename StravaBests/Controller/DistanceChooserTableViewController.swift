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
    lazy var distances: [Distance] = Distance.distances(upto: runs.maxDistance)
    var runs = Runs(with: [Run]())

    
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
        for run in runs.all {
            print("Name: \(run.name)")
            print("Bests: \(run.bests)")
        }
    }
    
    lazy var logoutButton: UIBarButtonItem =  UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(DistanceChooserTableViewController.logout))
        

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
