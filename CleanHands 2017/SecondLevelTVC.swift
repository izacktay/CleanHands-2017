//
//  SecondLevelTVC.swift
//  CleanHands 2017
//
//  Created by Dian Aisyah Binti Ramli on 30/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class SecondLevelTVC: UITableViewController {
    
    let dc = DataController.sharedInstance
    
    
    var conditionArr : [Bool] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionArr =  Array(repeating: false, count: dc.conditionCount )
        
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
                return dc.conditionSurveyCount(type: condition)
            }
        }
        return 0
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let section = indexPath.section
        
        if (section == 0){
            
            let row = indexPath.row
            let condition = dc.getCondition(index: row)
            if let label = cell.textLabel{
                label.text = condition
            }
            
            
            
        } else {
            
            if (conditionArr[section - 1] == true){
                let row = indexPath.row
                let condition = dc.getCondition(index: section - 1)
                let conditionSurveys = dc.getConditionSurveys(condition: condition)
                
                let conditionSurvey = dc.getConditionSurvey(condition: conditionSurveys, index: row)
                if let label = cell.textLabel{
                    label.text = conditionSurvey
                }
            }else{
                if let label = cell.textLabel{
                    label.text = ""
                }
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // 2 parts to this method. 1st is to handle the selection of rows of the first part, to display the second level
        // secondly, selection of the second level data.
        // ensure
        
        let section = indexPath.section
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .checkmark
        }
        
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
            tableView.reloadSections([1, 2, 3], with: .automatic)
            
        }else {
            
            let wd = SecondLevelData(description: "sd")
            
        }
        
        //        if (airborne == false){
        //
        //            if(cell?.textLabel!.text == "Airborne"){
        //                airborne = true
        //            }
        //
        //        }
        //        if (contact == false){
        //            if(cell?.textLabel!.text == "Contact"){
        //                contact = true
        //            }
        //        }
        //        if (droplet == false){
        //            if(cell?.textLabel!.text == "Droplet"){
        //                droplet = true
        //            }
        //        }
        
        
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.allowsMultipleSelection = true
        let section = indexPath.section
        
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .none
        }
        
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
            
            
        }else{
            
        }
        
        
        
        
        //        if(cell?.textLabel!.text == "Airborne"){
        //            airborne = false
        //        }
        //        if(cell?.textLabel!.text == "Contact"){
        //            contact = false
        //        }
        //        if(cell?.textLabel!.text == "Droplet"){
        //            droplet = false
        //        }
        
        
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
    
    
    
}
