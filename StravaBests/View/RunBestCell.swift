//
//  BestsCell.swift
//  StravaBests
//
//  Created by Genevieve Timms on 02/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class RunBestCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    
    func configure(with viewModel: RunBestCellViewModel) {
        self.nameLabel.text = viewModel.runName
        self.dateLabel.text = viewModel.runDate
        self.timelabel.text = viewModel.runTime
        self.bestLabel.text = viewModel.distanceBest
    }
    
}
