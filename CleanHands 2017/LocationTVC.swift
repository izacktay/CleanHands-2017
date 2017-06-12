//
//  MainTableViewController.swift
//  CleanHands 2017
//
//  Created by Izack on 26/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit
import MessageUI

class LocationTVC: UITableViewController, MFMailComposeViewControllerDelegate {
  
  var outTF : UITextField?
  
  let dc = DataController.sharedInstance
  
  //MARK: Archiving Paths
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let aURLlocations = DocumentsDirectory.appendingPathComponent("locations")
  static let aURLOutLoc = DocumentsDirectory.appendingPathComponent("outLoc")
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Load any saved location, otherwise load sample data.
    if let newOne = dc.loadLocations() {
      dc.newLocations = newOne
    } else {
      dc.loadDefaultLocations()
    }
    
    let add : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(LocationTVC.addTapped(_:)))
    navigationItem.rightBarButtonItems = [editButtonItem, add]
    
    if !MFMailComposeViewController.canSendMail() {
      print("Mail service not available")
      return
    }
    
    
  }
  
  func addTapped(_ button:UIBarButtonItem!) {
    
    
    // create a UIAlertController object
    
    let alert = UIAlertController(title: "Enter new Location",
                                  message: "",
                                  preferredStyle:UIAlertControllerStyle.alert)
    
    // create a UIAlertAction object
    let cancelAction = UIAlertAction(title:"Cancel",
                                     style: UIAlertActionStyle.default,
                                     handler: nil)
    
    // create a UIAlertAction object
    let addAction = UIAlertAction(title:"Add",
                                  style: UIAlertActionStyle.default,
                                  handler: addLocation)
    
    // add the UIAlertAction object to the UIAlertController object
    alert.addAction(cancelAction)
    alert.addAction(addAction)
    alert.addTextField{
      (UITextField) in self.outTF = UITextField
    }
    
    // display the UIAlertController object
    present(alert, animated: true, completion: nil)
  }
  
  func addLocation(_ alert : UIAlertAction) {
    
    let name = outTF?.text
    if(dc.newLocations == []){
      var locations = dc.getLocations()
      locations.insert(name!, at: 0)
      
      dc.newLocations = locations
      dc.savedLocations()
      
      tableView.reloadData()
      
    } else {
      var locations = dc.newLocations
      locations.insert(name!, at: 0)
      
      dc.newLocations = locations
      dc.savedLocations()
      
      tableView.reloadData()

      
    }
    
  }
  
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(dc.newLocations == []){
      return dc.locationsCount
    } else {
      return dc.newLocations.count
    }
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
    
    let row = indexPath.row
    
    if (dc.newLocations == []){
      let location = dc.getLocation(index: row)
      if let label = cell.textLabel{
        label.text = location
      }
      
      if(dc.getLocation(index: row) == dc.location){
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
      
      
    } else {
      let location = dc.newLocations[row]
      if let label = cell.textLabel{
        label.text = location
      }
      
      if(dc.newLocations[row] == dc.outLocations){
        cell.accessoryType = .checkmark
      } else if (dc.newLocations[row] == dc.loadLocation()){
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
      
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let row = indexPath.row
    
    if(dc.newLocations.isEmpty){
      let locations = dc.getLocations()
      dc.outLocations = locations[row]
      
      dc.savedLocation()
    } else {
      let locations = dc.newLocations
      dc.outLocations = locations[row]
      
      print(dc.outLocations, #line)
      dc.savedLocation()
    }
    
    performSegue(withIdentifier: "fromLocation", sender: self)
  }
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    if(dc.newLocations == []){
      var locations = dc.getLocations()
      let itemToMove = locations[sourceIndexPath.row]
      locations.remove(at: sourceIndexPath.row)
      locations.insert(itemToMove, at: destinationIndexPath.row)
      
      dc.newLocations = locations
      dc.savedLocations()
    } else {
      var locations = dc.newLocations
      let itemToMove = locations[sourceIndexPath.row]
      locations.remove(at: sourceIndexPath.row)
      locations.insert(itemToMove, at: destinationIndexPath.row)
      
      dc.newLocations = locations
      dc.savedLocations()
      
    }
  }
  
  
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    let row = indexPath.row
    
    if editingStyle == .delete {
      if(dc.newLocations == []){
        var locations = dc.getLocations()
        locations.remove(at: row)
        
        dc.newLocations = locations
        dc.savedLocations()
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        
      } else {
        var locations = dc.newLocations
        locations.remove(at: row)
        
        dc.newLocations = locations
        dc.savedLocations()
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        
      }
    }
  }
}







