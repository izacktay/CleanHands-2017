//
//  ObservationsTVC.swift
//  CleanHands 2017
//
//  Created by Izack on 26/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class ObservationsTVC: UITableViewController {
    
    let dc = DataController.sharedInstance

    @IBOutlet weak var outRole: UILabel!
    @IBOutlet weak var outRank: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // update role label to dc's role value
        outRole.text = dc.role
        outRank.text = dc.rank
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0){
            if (indexPath.row == 0){
                
            }
        }
    }

    // saving records as a single object to records class
    @IBAction func actSaveRecords(_ sender: Any) {
        let record = Records(role: outRank.text!, rank: outRank.text!, label1: outRank.text!)
        
    }
    

}
