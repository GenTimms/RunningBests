//
//  BestsTableViewDataSource.swift
//  StravaBests
//
//  Created by Genevieve Timms on 24/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import UIKit

class BestsTableViewDataSource: NSObject, UITableViewDataSource {
    
    var runs = [Run]()
    
    override init() {
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

}