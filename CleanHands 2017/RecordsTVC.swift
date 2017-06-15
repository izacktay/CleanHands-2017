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
    @IBOutlet weak var outLoc: UILabel!
    @IBOutlet weak var outMoments: UILabel!
    @IBOutlet weak var outConditions: UILabel!
    @IBOutlet weak var outNotes: UILabel!
    
    var updatedRole = ""
    var updatedRank = ""
    var updatedLoc = ""
    var switchState : Bool = false
    var switchString : String = ""
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //saving the array of boolean of condition survey
    
    var test : String = ""
    
    var action : String = ""
    
    var notes : String = ""
    
    var defaultCondition = ConditionsData(description: "")
    
    
    // set everything to false, so it wont have out of range index. values will always be passed
    var condition : [ConditionsData] = []
    
    let opData = ObservationPointData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let newRole = dc.loadRole(){
            updatedRole = newRole
            outRole.text = updatedRole
        } else {
            loadDefaultRole()
            
        }
        
        if let newRank = dc.loadRank(){
            updatedRank = newRank
            outRank.text = updatedRank
        } else {
            loadDefaultRank()
        }
        
        if let newLoc = dc.loadLocation(){
            updatedLoc = newLoc
            outLoc.text = updatedLoc
        } else {
            loadDefaultLoc()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print(updatedRank)
        print(notes)
    }
    
    // saving records as a single object to records class
    
    @IBAction func actSaveRecord(_ sender: UIBarButtonItem) {
        if(outRole.text == "Role" || outRank.text == "Rank" || outLoc.text == "Location"){
            let alert = UIAlertController(title: "Error",
                                          message: "Please fill in all selections",
                                          preferredStyle:UIAlertControllerStyle.alert)
            
            // create a UIAlertAction object
            let okAction = UIAlertAction(title:"OK",
                                         style: UIAlertActionStyle.default,
                                         handler: nil)
            
            // add the UIAlertAction object to the UIAlertController object
            alert.addAction(okAction)
            
            // display the UIAlertController object
            present(alert, animated: true, completion: nil)
        } else {
            //saving segmented control (actions), notes (notes), Conditions (conditions)
            // into one Observation Point data (ops)
            
            
            
            print(test)
            //for the action, get the text label of the cell: wash/rub/no
            
            if (condition.isEmpty == false){
                opData.conditions = condition
            }else{
                condition = Array(repeating: defaultCondition, count: 4)
                opData.conditions = condition
            }
            opData.actions = action
            opData.notes = notes
            dc.observationPoint = opData
            
            dc.momentName = outMoments.text!
            dc.role = outRole.text!
            dc.rank = outRank.text!
            dc.location = outLoc.text!
            dc.roleFullText = dc.getRoleFullText(role: dc.role)
            
        
            
            dc.createRecord()

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    private func loadDefaultRole(){
        outRole.text = dc.role
        outRole.textColor = UIColor.blue
    }
    
    private func loadDefaultRank(){
        outRank.text = dc.rank
        outRank.textColor = UIColor.blue
    }
    
    private func loadDefaultLoc(){
        outLoc.text = dc.location
        outLoc.textColor = UIColor.blue
    }
    
    @IBAction func unwindFromRole(_ segue : UIStoryboardSegue){
        outRole.text = dc.outRole
        outRole.textColor = UIColor.blue
    }
    
    @IBAction func unwindFromRank(_ segue : UIStoryboardSegue){
        outRank.text = dc.outRank
        outRank.textColor = UIColor.blue
    }
    
    @IBAction func unwindFromConditions(_ segue: UIStoryboardSegue){
        outConditions.textColor = UIColor.blue
    }
    
    @IBAction func unwindFromLocation(_ segue: UIStoryboardSegue){
        outLoc.text = dc.outLocations
        outLoc.textColor = UIColor.blue
    }
    
    @IBAction func unwindFromNotes(_ segue: UIStoryboardSegue){
        outNotes.textColor = UIColor.blue
    }
    
    @IBAction func unwindFromMoments(_ segue: UIStoryboardSegue){
        outMoments.text = dc.momentName
        outMoments.textColor = UIColor.blue
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        if (section == 2){
            if let cell = tableView.cellForRow(at: indexPath){
                cell.accessoryType = .checkmark
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        if (section == 2){
            if let cell = tableView.cellForRow(at: indexPath){
                cell.accessoryType = .none
            }
        }
    }
    
    
}

