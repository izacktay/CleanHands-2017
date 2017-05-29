//
//  RankTVC.swift
//  CleanHands 2017
//
//  Created by Izack on 29/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class RankTVC: UITableViewController {
    
    let dc = DataController.sharedInstance
  
  //MARK: Archiving Paths
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let aURLRanks = DocumentsDirectory.appendingPathComponent("ranks")
  static let aURLoutRank = DocumentsDirectory.appendingPathComponent("outRank")

    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.rightBarButtonItem = editButtonItem
      
      // Load any saved location, otherwise load sample data.
      if let newOne = dc.loadRanks() {
        dc.newRanks = newOne
      } else {
        dc.loadDefaultRanks()
      }
    }

  // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        
//        var count = 0
//        let role = dc.role
//        if (role == "Role"){
//            count = 0
//        }else {
//            count = dc.getRanks(role: role).count
//        }
//        return count
      
      
      var count = 0
      dc.outRole = dc.loadRole()!
      
      if(dc.outRole == ""){
        let role = dc.role
        if (role == "Role"){
          count = 0
        }else {
          let numberOfRows = dc.getRanks(role: role).count
          count = numberOfRows
        }
      } else {
        let numberOfRows = dc.newRanks.count
        count = numberOfRows
      }
      return count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell", for: indexPath)
//        
//        let row = indexPath.row
//        let role = dc.role
//        let ranks = dc.getRanks(role: role)
//        
//        let rank = dc.getRank(rank: ranks, index: row)
//        if let label = cell.textLabel{
//            label.text = rank
//        }
//
//        if(rank == dc.rank){
//            cell.accessoryType = .checkmark
//        }
//        
//        return cell
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell", for: indexPath)
      
      let row = indexPath.row
      
      if (dc.newRanks.isEmpty){
        let role = dc.role
        let ranks = dc.getRanks(role: role)
        let rank = dc.getRank(rank: ranks, index: row)
        if let label = cell.textLabel{
          label.text = rank
        }
        dc.newRanks = ranks
        dc.savedRanks()
        
        if(dc.getRank(rank: ranks, index: row) == dc.outRank){
          cell.accessoryType = .checkmark
        }
        
      } else {
        let ranks = dc.newRanks
        let rank = dc.getRank(rank: ranks, index: row)
        if let label = cell.textLabel{
          label.text = rank
        }
        dc.newRanks = ranks
        dc.savedRanks()
        
        
        if(dc.newRanks[row] == dc.outRank){
          cell.accessoryType = .checkmark
        }
        
      }
      
      return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let row = indexPath.row
//        
//        let role = dc.role
//        let ranks = dc.getRanks(role: role)
//        dc.rank = dc.getRank(rank: ranks, index: row)
//        
//        if let nc = self.navigationController{
//            nc.popViewController(animated: true)
//        }
      let row = indexPath.row
      
      //    let role = dc.role
      //    let ranks = dc.getRanks(role: role)
      //    dc.rank = dc.getRank(role: ranks, index: row)
      
      if(dc.newRanks.isEmpty){
        let role = dc.role
        let ranks = dc.getRanks(role: role)
        dc.outRank = dc.getRank(rank: ranks, index: row)
        
        dc.savedRank()
      } else {
        dc.outRank = dc.getRank(rank: dc.newRanks, index: row)
        dc.savedRank()
      }
      
      //    if let nc = self.navigationController{
      //      nc.popViewController(animated: true)
      //    }
      
      performSegue(withIdentifier: "fromRank", sender: self)

    }
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    if(dc.newRanks.isEmpty){
      var ranks = dc.getRanks(role: dc.outRole)
      let itemToMove = ranks[sourceIndexPath.row]
      ranks.remove(at: sourceIndexPath.row)
      ranks.insert(itemToMove, at: destinationIndexPath.row)
      
      dc.newRanks = ranks
      dc.savedRanks()
      
    } else {
      var ranks = dc.newRanks
      let itemToMove = ranks[sourceIndexPath.row]
      ranks.remove(at: sourceIndexPath.row)
      ranks.insert(itemToMove, at: destinationIndexPath.row)
      dc.newRanks = ranks
      
      dc.savedRanks()
      
    }
    
  }
  
}
