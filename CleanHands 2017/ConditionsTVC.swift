//
//  SecondLevelTVC.swift
//  CleanHands 2017
//
//  Created by Dian Aisyah Binti Ramli on 30/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class ConditionsTVC: UITableViewController {
    
    let dc = DataController.sharedInstance
    
    //array to determine if the condition are selected
    var conditionArr : [Bool] = []
    
    // array to determine if the condition survey are selected
    var selConditionsArr : [Bool] = []
    var condData = ConditionsData(description: "")
    var selCondArr : [ConditionsData] = []
    
    // identify which button was pressed
    var segueIdentifier = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionArr =  Array(repeating: false, count: dc.conditionCount)
        selConditionsArr =  Array(repeating: false, count: 4)
        selCondArr = Array(repeating: condData, count: 4)
        print(segueIdentifier)
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return dc.conditionCount
        }else {
            if (conditionArr[section - 1] == true){
                let condition = dc.getCondition(index: section - 1)
                return dc.conditionItemCount(type: condition)
            }
        }
        return 0
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        
        if (section == 0){
            let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: "conditions", for: indexPath)
            let condition = dc.getCondition(index: row)
            if let label = cell.textLabel{
                label.text = condition
            }
            
            return cell
            
        } else {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "items", for: indexPath) as! CustomRecordsTVCCell
            
            if (conditionArr[section - 1] == true){
                
                
                let row = indexPath.row
                let condition = dc.getCondition(index: section - 1)
                let conditionSurveys = dc.getConditionItems(condition: condition)
                
                let conditionSurvey = dc.getConditionItem(conditionSurvey: conditionSurveys, index: row)
                cell.outLabel.text = conditionSurvey
                
            }
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if (indexPath == [1,0] || indexPath == [2,0] || indexPath == [2,1] || indexPath == [3,0]){
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // 2 parts to this method. 1st is to handle the selection of rows of the first part, to display the second level
        // secondly, selection of the second level data.
        // ensure
        
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "items", for: indexPath) as! CustomRecordsTVCCell
        
        
        if (section == 0){
            
            tableView.allowsMultipleSelection = true
            
            
            if (conditionArr[0] == false){
                
                if (indexPath.row == 0){
                    conditionArr[0] = true
                    tableView.reloadSections([1], with: .automatic)
                }
                
            }
            if (conditionArr[1] == false){
                if (indexPath.row == 1){
                    conditionArr[1] = true
                    tableView.reloadSections([2], with: .automatic)
                }
                
            }
            if (conditionArr[2] == false){
                if (indexPath.row == 2){
                    conditionArr[2] = true
                    tableView.reloadSections([3], with: .automatic)
                }
                
            }
            
            if let cell = tableView.cellForRow(at: indexPath){
                cell.accessoryType = .checkmark
            }
            
        }
        
//        // will set the selCondtionsArr to true or false, to determine whether its selected <--
//        
//        if (section == 1){
//            
//            if(selConditionsArr[0] == false){
//                selConditionsArr[0] = true
//                if let segmentItem = cell.outSegmentControl{
//                    // set the yes/NA/no
//                    dc.n95.items = (segmentItem.selectedSegmentIndex != UISegmentedControlNoSegment) ? segmentItem.titleForSegment(at: segmentItem.selectedSegmentIndex)! : ""
//                }
//                selCondArr[0] = dc.n95
//            }
//        }
//        
//        if (section == 2){
//            let row = indexPath.row
//            
//            if (row == 0){
//                if (selConditionsArr[1] == false){
//                    selConditionsArr[1] = true
//                    if let segmentItem = cell.outSegmentControl{
//                        // set the yes/NA/no
//                        dc.glove.items = (segmentItem.selectedSegmentIndex != UISegmentedControlNoSegment) ? segmentItem.titleForSegment(at: segmentItem.selectedSegmentIndex)! : ""
//                    }
//                    selCondArr[1] = dc.glove
//                }
//            }else {
//                if (selConditionsArr[2] == false){
//                    selConditionsArr[2] = true
//                    if let segmentItem = cell.outSegmentControl{
//                        // set the yes/NA/no
//                        dc.gown.items = (segmentItem.selectedSegmentIndex != UISegmentedControlNoSegment) ? segmentItem.titleForSegment(at: segmentItem.selectedSegmentIndex)! : ""
//                    }
//                    selCondArr[2] = dc.gown
//                }
//            }
//            
//        }
//        if (section == 3){
//            
//            if(selConditionsArr[3] == false){
//                selConditionsArr[3] = true
//                if let segmentItem = cell.outSegmentControl{
//                    // set the yes/NA/no
//                    dc.mask.items = (segmentItem.selectedSegmentIndex != UISegmentedControlNoSegment) ? segmentItem.titleForSegment(at: segmentItem.selectedSegmentIndex)! : ""
//                }
//                selCondArr[3] = dc.mask
//            }
//        }
//        // -->
//        print(selConditionsArr)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.allowsMultipleSelection = true
        let section = indexPath.section
        
        
        if (section == 0){
            
            if (conditionArr[0] == true){
                
                if (indexPath.row == 0){
                    conditionArr[0] = false
                    tableView.reloadSections([1], with: .automatic)
                }
                
                
            }
            if (conditionArr[1] == true){
                if (indexPath.row == 1){
                    conditionArr[1] = false
                    tableView.reloadSections([2], with: .automatic)
                }
                
            }
            if (conditionArr[2] == true){
                if (indexPath.row == 2){
                    conditionArr[2] = false
                    tableView.reloadSections([3], with: .automatic)
                }
                
            }
            
            if let cell = tableView.cellForRow(at: indexPath){
                cell.accessoryType = .none
            }
            
            
        }
        // same concept as selecting the row, but now its deselecting. will set it to false
        if (section == 1){
            
            if(selConditionsArr[0] == true){
                selConditionsArr[0] = false
            }
        }
        
        if (section == 2){
            let row = indexPath.row
            
            if (row == 0){
                if (selConditionsArr[1] == true){
                    selConditionsArr[1] = false
                }
            }else {
                if (selConditionsArr[2] == true){
                    selConditionsArr[2] = false
                }
            }
            
        }
        if (section == 3){
            
            if(selConditionsArr[3] == true){
                selConditionsArr[3] = false
            }
        }
        
        print(selConditionsArr)
        
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        if (section == 0){
            return "Conditions"
        }
        else if (section == 1){
            return "Airborne"
        }
        else if (section == 2){
            return "Contact"
        }
        else {
            return "Droplet"
        }
        
        
    }
    
    // make an alert, tapping OK will call addConditions
    @IBAction func actDone(_ sender: UIBarButtonItem) {
        
        let title = "Confirm?"
        
        let message = "N95: \(selConditionsArr[0]) \n Glove: \(selConditionsArr[1]) \n Gown: \(selConditionsArr[2]) \n Mask: \(selConditionsArr[3])"
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle:UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title:"OK",
                                          style: UIAlertActionStyle.default, handler: addConditions)
        
        let cancelAction = UIAlertAction(title:"Cancel",
                                         style: UIAlertActionStyle.cancel, handler: cancelAct)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // add the array into the data controller's array, depending on which segue was called.
    func addConditions (_ alert : UIAlertAction){
        
        performSegue(withIdentifier: "unwindCondition", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rTVC = segue.destination as! RecordsTVC
        // assign the selCondtionsArr to the BooleanArr array list in ObservationsTVC
        if (segueIdentifier == "sls1"){
            rTVC.condition1 = selCondArr
            rTVC.test = "test test"
        }else if (segueIdentifier == "sls2"){
            rTVC.condition2 = selCondArr
        }else if (segueIdentifier == "sls3"){
            rTVC.condition3 = selCondArr
        }else if (segueIdentifier == "sls4"){
            rTVC.condition4 = selCondArr
        }else if (segueIdentifier == "sls5"){
            rTVC.condition5 = selCondArr
        }
    }
    
    
    
    
    
    func cancelAct (_ alert : UIAlertAction){
        
    }
    
    
    
}
