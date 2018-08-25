//
//  RunTableViewController.swift
//  StravaBests
//
//  Created by Genevieve Timms on 02/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class RunBestsTableViewController: UITableViewController {
    
    @IBOutlet weak var runTitle: UILabel!
    @IBOutlet weak var runDate: UILabel!
    
    var run: Run?
    var distances = [Distance]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRunTitle()
        distances = run?.bests.keys.sorted { $0.meters < $1.meters } ?? []
    }
    
    private func setRunTitle() {
        if let unwrappedRun = run {
            let name = unwrappedRun.name
            let date = DateFormatter.dateAndTimeString(from: unwrappedRun.date)
            runTitle.text = name
            runDate.text = date
        }
    }
    
    // MARK: - TableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distances.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.runBest, for: indexPath)
        if let runBestCell = cell as? RunBestsCell, let cellRun = run {
            if indexPath.row == distances.count {
                runBestCell.configure(with: RunBestsCellViewModel(run: cellRun))
            } else {
                runBestCell.configure(with: RunBestsCellViewModel(distance: distances[indexPath.row], run: cellRun))
            }
        }
        return cell
    }
}
