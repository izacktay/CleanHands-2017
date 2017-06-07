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
    
    var updatedRole = ""
    var updatedRank = ""
    var switchState : Bool = false
    var switchString : String = ""
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    
    //saving the array of boolean of condition survey
    
    
    @IBOutlet weak var segAction1: UISegmentedControl!
    @IBOutlet weak var segAction2: UISegmentedControl!
    @IBOutlet weak var segAction3: UISegmentedControl!
    @IBOutlet weak var segAction4: UISegmentedControl!
    @IBOutlet weak var segAction5: UISegmentedControl!
    var test : String = ""
    
    var notes1 : String = ""
    var notes2 : String = ""
    var notes3 : String = ""
    var notes4 : String = ""
    var notes5 : String = ""
    
    var defaultCondition = ConditionsData(description: "")
    
    
    // set everything to false, so it wont have out of range index. values will always be passed
    var condition1 : [ConditionsData] = []
    var condition2 : [ConditionsData] = []
    var condition3 : [ConditionsData] = []
    var condition4 : [ConditionsData] = []
    var condition5 : [ConditionsData] = []
    
    let opData1 = ObservationPointData()
    let opData2 = ObservationPointData()
    let opData3 = ObservationPointData()
    let opData4 = ObservationPointData()
    let opData5 = ObservationPointData()
    
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
        
        
        defaultCondition.selected = false
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print(updatedRank)
        print(notes1)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // saving records as a single object to records class
    
    
    
    @IBAction func actSaveRecord(_ sender: UIBarButtonItem) {
        //saving segmented control (actions), notes (notes), Conditions (conditions)
        // into one Observation Point data (ops)
        
        // get the title of the segments
        // need guard statements to condition if segments are not selected
        let  action1 : String = segAction1.titleForSegment(at: segAction1.selectedSegmentIndex)!
        let  action2 : String = segAction2.titleForSegment(at: segAction2.selectedSegmentIndex)!
        let  action3 : String = segAction3.titleForSegment(at: segAction3.selectedSegmentIndex)!
        let  action4 : String = segAction4.titleForSegment(at: segAction4.selectedSegmentIndex)!
        let  action5 : String = segAction5.titleForSegment(at: segAction5.selectedSegmentIndex)!
        
        //saving
        
        
        print(test)
        opData1.actions = action1
        opData1.notes = notes1
        if (condition1.isEmpty == false){
            opData1.conditions = condition1
        }else{
            condition1 = Array(repeating: defaultCondition, count: 4)
            opData1.conditions = condition1
        }
        
        
        opData2.actions = action2
        opData2.notes = notes2
        if (condition2.isEmpty == false){
            opData2.conditions = condition2
        }else{
            condition2 = Array(repeating: defaultCondition, count: 4)
            opData2.conditions = condition2
        }
        
        opData3.actions = action3
        opData3.notes = notes3
        if (condition3.isEmpty == false){
            opData3.conditions = condition3
        }else{
            condition3 = Array(repeating: defaultCondition, count: 4)
            opData3.conditions = condition3
        }
        
        opData4.actions = action4
        opData4.notes = notes4
        if (condition4.isEmpty == false){
            opData4.conditions = condition4
        }else{
            condition4 = Array(repeating: defaultCondition, count: 4)
            opData4.conditions = condition4
        }
        
        opData5.actions = action5
        opData5.notes = notes5
        if (condition5.isEmpty == false){
            opData5.conditions = condition5
        }else{
            condition5 = Array(repeating: defaultCondition, count: 4)
            opData5.conditions = condition5
        }
        
        dc.observationArr.append(opData1)
        dc.observationArr.append(opData2)
        dc.observationArr.append(opData3)
        dc.observationArr.append(opData4)
        dc.observationArr.append(opData5)
        
        dc.role = outRole.text!
        dc.rank = outRank.text!
        
        dc.createRecord()
        dc.createCSV()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // conditions
        if(segue.identifier == "sls1"){
            let sls = segue.destination as! ConditionsTVC
            sls.segueIdentifier = "sls1"
        }else if(segue.identifier == "sls2"){
            let sls = segue.destination as! ConditionsTVC
            sls.segueIdentifier = "sls2"
        }else if(segue.identifier == "sls3"){
            let sls = segue.destination as! ConditionsTVC
            sls.segueIdentifier = "sls3"
        }else if(segue.identifier == "sls4"){
            let sls = segue.destination as! ConditionsTVC
            sls.segueIdentifier = "sls4"
        }else if(segue.identifier == "sls5"){
            let sls = segue.destination as! ConditionsTVC
            sls.segueIdentifier = "sls5"
        }
        
        // notes
        if (segue.identifier == "notes1"){
            let notes = segue.destination as! NotesVC
            notes.segueIdentifier = "notes1"
        }else if (segue.identifier == "notes2"){
            let notes = segue.destination as! NotesVC
            notes.segueIdentifier = "notes2"
        }else if (segue.identifier == "notes3"){
            let notes = segue.destination as! NotesVC
            notes.segueIdentifier = "notes3"
        }else if (segue.identifier == "notes4"){
            let notes = segue.destination as! NotesVC
            notes.segueIdentifier = "notes4"
        }else if (segue.identifier == "notes5"){
            let notes = segue.destination as! NotesVC
            notes.segueIdentifier = "notes5"
        }
        
    }
    
    private func loadDefaultRole(){
        outRole.text = dc.role
    }
    
    private func loadDefaultRank(){
        outRank.text = dc.rank
    }
    
    @IBAction func unwindFromRole(_ segue : UIStoryboardSegue){
        outRole.text = dc.outRole
        outRank.text = dc.outRank
    }
    
    @IBAction func unwindFromRank(_ segue : UIStoryboardSegue){
        outRank.text = dc.outRank
        print(#line, dc.outRank)
    }
    
    @IBAction func unwindFromConditions(_ segue: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindFromSettings(_ segue: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindFromLocation(_ segue: UIStoryboardSegue){
        
    }
    
    
    
    @IBAction func actAction1(_ sender: UISegmentedControl) {
        guard switchState == true else{
            return
        }
        if (sender.selectedSegmentIndex == 2){
            performSegue(withIdentifier: "notes1", sender: self)
            print(switchString)
        }
        
    }
    
    
    @IBAction func actAction2(_ sender: UISegmentedControl) {
        guard switchState == true else{
            return
        }
        if (sender.selectedSegmentIndex == 2){
            performSegue(withIdentifier: "notes2", sender: self)
        }
    }
    
    
    @IBAction func actAction3(_ sender: UISegmentedControl) {
        guard switchState == true else{
            return
        }
        if (sender.selectedSegmentIndex == 2){
            performSegue(withIdentifier: "notes3", sender: self)
        }
    }
    
    
    @IBAction func actAction4(_ sender: UISegmentedControl) {
        guard switchState == true else{
            return
        }
        if (sender.selectedSegmentIndex == 2){
            performSegue(withIdentifier: "notes4", sender: self)
        }
    }
    
    @IBAction func actAction5(_ sender: UISegmentedControl) {
        guard switchState == true else{
            return
        }
        if (sender.selectedSegmentIndex == 2){
            performSegue(withIdentifier: "notes5", sender: self)
        }
    }
    
    

}

