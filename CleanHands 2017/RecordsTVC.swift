//
//  ObservationsTVC.swift
//  CleanHands 2017
//
//  Created by Izack on 26/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class RecordsTVC: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  let dc = DataController.sharedInstance
  
  @IBOutlet weak var outRole: UILabel!
  @IBOutlet weak var outRank: UILabel!
  @IBOutlet weak var outLoc: UILabel!
  @IBOutlet weak var outRemark: UITextField!
  @IBOutlet weak var outMomentsCV: UICollectionView!
  
  var updatedRole = ""
  var updatedRank = ""
  var updatedLoc = ""
  var updatedRemark = ""
  var switchState : Bool = false
  var switchString : String = ""
  
  //MARK: Archiving Paths
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  
  static let aURLremark = DocumentsDirectory.appendingPathComponent("remark")
  
  
  //saving the array of boolean of condition survey
  
  var test : String = ""
  
  var action1 : String = ""
  var action2 : String = ""
  var action3 : String = ""
  var action4 : String = ""
  var action5 : String = ""
  
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
    
    if let newLoc = dc.loadLocation(){
      updatedLoc = newLoc
      outLoc.text = updatedLoc
    } else {
      loadDefaultLoc()
    }
    
    if let newRemark = dc.loadRemark(){
      updatedRemark = newRemark
      outRemark.text = updatedRemark
    }
    
    
    defaultCondition.selected = false
    
    outMomentsCV.delegate = self
    outMomentsCV.dataSource = self
    
  }
  override func viewDidAppear(_ animated: Bool) {
    print(notes1)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    dc.outRemark = outRemark.text ?? ""
    dc.savedRemark()
    
  }
  
  // saving records as a single object to records class
  
  @IBAction func actClearRecord(_ sender: UIBarButtonItem) {
    outLoc.text = ""
    dc.savedLocation()
    
    outRole.text = ""
    dc.savedRole()
    
    outRank.text = ""
    dc.savedRank()
    
    outRemark.text = ""
    
  }
  
  
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
      dc.location = outLoc.text!
      
      
      dc.createRecord()
      dc.createCSV()
    }
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
  
  private func loadDefaultLoc(){
    outLoc.text = dc.location
  }
  
  @IBAction func unwindFromRole(_ segue : UIStoryboardSegue){
    outRole.text = dc.outRole
  }
  
  @IBAction func unwindFromRank(_ segue : UIStoryboardSegue){
    outRank.text = dc.outRank
  }
  
  @IBAction func unwindFromConditions(_ segue: UIStoryboardSegue){
    
  }
  
  @IBAction func unwindFromSettings(_ segue: UIStoryboardSegue){
    
  }
  
  @IBAction func unwindFromLocation(_ segue: UIStoryboardSegue){
    outLoc.text = dc.outLocations
  }
  
  @IBAction func unwindFromNotes(_ segue: UIStoryboardSegue){
    
  }
  
  //moments collevtion view
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                  for: indexPath) as! MomentsCollectionViewCell
    
    let item = indexPath.item
    
    if (item == 0){
      cell.outLabel.text = "Before"
    }else{
      cell.outLabel.text = "The rest"
    }
    
    return cell
  }
  
  
  // called to ask if cell should be selected
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // called when cell transitions from deselected to selected
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    print("\(#function) \(indexPath)")
    
    if let cell = collectionView.cellForItem(at:indexPath) {
      cell.backgroundColor = UIColor.blue
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      shouldDeselectItemAt indexPath: IndexPath) -> Bool {
    return true
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if let cell = collectionView.cellForItem(at:indexPath){
      cell.backgroundColor = UIColor.gray
    }
    
  }
  
  
  
}

