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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = logoutButton
        
        if let detailVC = splitViewController?.viewControllers[1].contents as? DistanceBestsTableViewController, let distance = distances.first {
            detailVC.runs = runs.withBests(for: distance)
            detailVC.distance = distance
        }
    }
    
    //MARK: - Logout
    lazy var logoutButton: UIBarButtonItem =  UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(DistanceChooserTableViewController.logout))
    
    
    @objc func logout() {
        performSegue(withIdentifier: "logout", sender: self)
    }
    
    
    //MARK: - Refresh
    
    @IBAction func refreshRuns(_ sender: Any? = nil) {
        guard let refreshControl = sender as? UIRefreshControl else {
            return
        }
        fetchRuns {
            refreshControl.endRefreshing()
        }
    }
    
    var client: APIClient?
    
    private func fetchRuns(completion: @escaping () -> Void) {
        client!.fetchRuns() { result in
            switch result {
            case.success(let fetchedRuns): self.runs = fetchedRuns; self.tableView.reloadData(); completion()
            case.failure(let error): print("Refresh Failed" + error.localizedDescription); completion()
            }
        }
    }
    
    //MARK: - SplitViewController
    
    private var collapseDetailViewController = true
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return collapseDetailViewController
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.bests {
            if let indexPath = sender as? IndexPath {
                if let bestsVC = segue.destination.contents as? DistanceBestsTableViewController {
                    let distance = distances[indexPath.row]
                    bestsVC.runs = runs.withBests(for: distance)
                    bestsVC.distance = distance
                    collapseDetailViewController = false
                }
            }
        }
    }
    
    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distances.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.distance, for: indexPath) as! DistanceChooserCell
        let distance = distances[indexPath.row]
        let viewModel = DistanceChooserCellViewModel(distance: distance, bestRun: runs.best(for: distance))
        cell.configure(with: viewModel)
        return cell
    }
    
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.bests, sender: indexPath)
    }
}
