//
//  RoleTVC.swift
//  CleanHands 2017
//
//  Created by Izack on 29/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class RoleTVC: UITableViewController {
  
  let dc = DataController.sharedInstance
  
  //MARK: Archiving Paths
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  
  static let aURLRoles = DocumentsDirectory.appendingPathComponent("roles")
  static let aURLoutRole = DocumentsDirectory.appendingPathComponent("outRole")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = editButtonItem
    
    // Load any saved location, otherwise load sample data.
    if let newOne = dc.loadRoles() {
      dc.newRoles = newOne
    } else {
      dc.loadDefaultRoles()
    }
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dc.roleCount
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "roleCell", for: indexPath)
    
    let row = indexPath.row
    
    if (dc.newRoles.isEmpty){
      let role = dc.getRole(index: row)
      if let label = cell.textLabel{
        label.text = role
      }
      dc.role = role
      
      if(dc.getRole(index: row) == dc.role){
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    } else {
      let role = dc.newRoles[row]
      if let label = cell.textLabel{
        label.text = role
      }
      dc.role = role
      
      if(dc.newRoles[row] == dc.outRole){
        cell.accessoryType = .checkmark
      } else if (dc.newRoles[row] == dc.loadRole()){
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = indexPath.row
    
    if(dc.newRoles.isEmpty){
      dc.role = dc.getRole(index: row)
      dc.savedRole()
      
      dc.newRanks = dc.getRanks(role: dc.role)
      dc.savedRanks()
      
    } else {
      dc.outRole = dc.newRoles[row]
      dc.savedRole()
      
      dc.newRanks = dc.getRanks(role: dc.outRole)
      dc.savedRanks()
      
    }
    dc.rank = "Rank"
    
    performSegue(withIdentifier: "fromRole", sender: self)

  }
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    if(dc.newRoles == []){
      var roles = dc.getRoles()
      let itemToMove = roles[sourceIndexPath.row]
      roles.remove(at: sourceIndexPath.row)
      roles.insert(itemToMove, at: destinationIndexPath.row)
      
      dc.newRoles = roles
      dc.savedRoles()
      
    } else {
      var roles = dc.newRoles
      let itemToMove = roles[sourceIndexPath.row]
      roles.remove(at: sourceIndexPath.row)
      roles.insert(itemToMove, at: destinationIndexPath.row)
      
      dc.newRoles = roles
      dc.savedRoles()
      
    }
  }
  
  
}
