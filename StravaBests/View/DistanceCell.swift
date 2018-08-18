//
//  DistanceCell.swift
//  StravaBests
//
//  Created by Genevieve Timms on 02/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class DistanceCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bestTimeLabel: UILabel!
    @IBOutlet weak var bestNameLabel: UILabel!
    @IBOutlet weak var bestDateLabel: UILabel!
    
    func configure(with viewModel: DistanceCellViewModel) {
        self.distanceLabel.text = viewModel.distance
        self.bestTimeLabel.text = viewModel.bestTime
        self.bestNameLabel.text = viewModel.bestName
        self.bestDateLabel.text = viewModel.bestDate
    }
    
}
