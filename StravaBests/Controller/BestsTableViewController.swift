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
    var runs = [Run]()
    
    var isChonological: Bool = true {
        didSet {
            if isChonological {
                runs.sort{$0.date > $1.date}
            } else {
                runs.sort{$0.bests[distance]! < $1.bests[distance]!}
            }
        }
    }

    @IBAction func sortButton(_ sender: Any) {
        isChonological = !isChonological
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.runBest, for: indexPath) as! RunBestCell
        let run = runs[indexPath.row]
        let viewModel = RunBestCellViewModel(distance: distance, run: run)
        cell.configure(with: viewModel)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
