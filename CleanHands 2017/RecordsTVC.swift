//
//  ObservationsTVC.swift
//  CleanHands 2017
//
//  Created by Izack on 26/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class RecordsTVC: UITableViewController {
    
    let dc = DataController.sharedInstance

    @IBOutlet weak var outRole: UILabel!
    @IBOutlet weak var outRank: UILabel!
    
    //saving the array of boolean of condition survey
    //5 arrays for each of the observation point
//    var conditionSurvey1 : [Bool] = []
//    var conditionSurvey2 : [Bool] = []
//    var conditionSurvey3 : [Bool] = []
//    var conditionSurvey4 : [Bool] = []
//    var conditionSurvey5 : [Bool] = []
    
    var conditionSurvey : [[Bool]] = [[], [], [], [], []]

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
    @IBAction func actSaveRecord(_ sender: UIBarButtonItem) {
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sls1"){
            let sls = segue.destination as! ConditionsTVC
            sls.segueIdentifier = "sls1"
        }else if(segue.identifier == "sls2"){
            let sls = segue.destination as! ConditionsTVC
            sls.segueIdentifier = "sls2"
        }else if(segue.identifier == "sls3"){
            let sls1 = segue.destination as! ConditionsTVC
            sls1.segueIdentifier = "sls3"
        }else if(segue.identifier == "sls4"){
            let sls1 = segue.destination as! ConditionsTVC
            sls1.segueIdentifier = "sls4"
        }else if(segue.identifier == "sls5"){
            let sls1 = segue.destination as! ConditionsTVC
            sls1.segueIdentifier = "sls5"
        }
    }
    

}
