//
//  DistanceCell.swift
//  StravaBests
//
//  Created by Genevieve Timms on 02/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class DistanceChooserCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bestTimeLabel: UILabel!
    
    func configure(with viewModel: DistanceChooserCellViewModel) {
        self.distanceLabel.text = viewModel.distance
        self.bestTimeLabel.text = viewModel.bestTime
    }
    
}
