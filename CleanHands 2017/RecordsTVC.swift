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
    
    
    @IBOutlet weak var segAction1: UISegmentedControl!
    @IBOutlet weak var segAction2: UISegmentedControl!
    @IBOutlet weak var segAction3: UISegmentedControl!
    @IBOutlet weak var segAction4: UISegmentedControl!
    @IBOutlet weak var segAction5: UISegmentedControl!
    
    
    var notes1 : String = ""
    var notes2 : String = ""
    var notes3 : String = ""
    var notes4 : String = ""
    var notes5 : String = ""
    
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

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // update role label to dc's role value
        outRole.text = dc.role
        outRank.text = dc.rank
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
        var  action1 : String = segAction1.titleForSegment(at: segAction1.selectedSegmentIndex)!
        var  action2 : String = segAction2.titleForSegment(at: segAction1.selectedSegmentIndex)!
        var  action3 : String = segAction3.titleForSegment(at: segAction1.selectedSegmentIndex)!
        var  action4 : String = segAction4.titleForSegment(at: segAction1.selectedSegmentIndex)!
        var  action5 : String = segAction5.titleForSegment(at: segAction1.selectedSegmentIndex)!
        
        
        //saving
        opData1.actions = action1
        opData1.notes = notes1
        opData1.conditions = condition1
        
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
    

}