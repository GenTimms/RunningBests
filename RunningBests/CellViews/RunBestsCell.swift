//
//  RunBestsCell.swift
//  StravaBests
//
//  Created by Genevieve Timms on 19/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class RunBestsCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
        func configure(with viewModel: RunBestsCellViewModel) {
            self.distanceLabel.text = viewModel.distance
            self.paceLabel.text = viewModel.pace
            self.timeLabel.text = viewModel.time
        }
}
    
