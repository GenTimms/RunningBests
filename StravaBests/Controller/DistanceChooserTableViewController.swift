//
//  DistanceChooserTableViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 01/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class DistanceChooserTableViewController: UITableViewController, UISplitViewControllerDelegate {
    
    lazy var distances: [Distance] = Distance.all(upto: runs.maxDistance)
    var runs = Runs(with: [Run]())

    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let btvc = secondaryViewController as? BestsTableViewController {
            if btvc.runs.isEmpty {
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
        if segue.identifier == Segues.Bests {
            if let indexPath = sender as? IndexPath {
                if let bestsVC = segue.destination.contents as? BestsTableViewController {
                    let distance = distances[indexPath.row]
                    bestsVC.runs = runs.withBests(for: distance)
                    bestsVC.distance = distance
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return distances.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.distance, for: indexPath) as! DistanceCell
        let distance = distances[indexPath.row]
        let viewModel = DistanceCellViewModel(distance: distance, bestRun: runs.best(for: distance))
        cell.configure(with: viewModel)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.Bests, sender: indexPath)
    }
}
