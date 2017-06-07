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
  @IBOutlet weak var outEmail: UIBarButtonItem!
  
  var outTF : UITextField?
  
  let dc = DataController.sharedInstance
  
  //MARK: Archiving Paths
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let aURLlocations = DocumentsDirectory.appendingPathComponent("locations")
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Load any saved location, otherwise load sample data.
    if let newOne = dc.loadLocations() {
      dc.newLocations = newOne
    } else {
      dc.loadDefaultLocations()
    }
    
    let button : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    navigationItem.rightBarButtonItems = [editButtonItem]
    
    if !MFMailComposeViewController.canSendMail() {
      print("Mail service not available")
      return
    }
    
    
    
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
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
    } else {
      let location = dc.newLocations[row]
      if let label = cell.textLabel{
        label.text = location
      }
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "fromLocation", sender: self)
  }
  
  //  @IBAction func actEmail(_ sender: UIBarButtonItem) {
  //    let composeVC = MFMailComposeViewController()
  //    composeVC.mailComposeDelegate = self
  //    composeVC.setToRecipients(["15017612@myrp.edu.sg"])
  //    composeVC.setSubject("'Sup")
  //    composeVC.setMessageBody("Testing", isHTML: false)
  //
  //    if let filePath = Bundle.main.path(forResource: "swifts", ofType: "wav") {
  //      print("File path loaded.")
  //
  //      if let fileData = NSData(contentsOfFile: filePath) {
  //        print("File data loaded.")
  //        composeVC.addAttachmentData(fileData as Data, mimeType: "audio/wav", fileName: "swifts")
  //      }
  //    }
  //    self.present(composeVC, animated: true, completion: nil)
  //  }
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
//  @IBAction func actEdit(_ sender: UIBarButtonItem) {
//    tableView.
//    
//  }
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
  
  
//    } else if editingStyle == .insert {
//      // create a UIAlertController object
//      let alert = UIAlertController(title: "Enter new Location",
//                                    message: "",
//                                    preferredStyle:UIAlertControllerStyle.alert)
//      
//      // create a UIAlertAction object
//      let cancelAction = UIAlertAction(title:"Cancel",
//                                       style: UIAlertActionStyle.default,
//                                       handler: nil)
//      
//      // create a UIAlertAction object
//      let addAction = UIAlertAction(title:"Add",
//                                        style: UIAlertActionStyle.default,
//                                        handler: nil)
//      
//      // add the UIAlertAction object to the UIAlertController object
//      alert.addAction(cancelAction)
//      alert.addAction(addAction)
//      alert.addTextField{
//        (UITextField) in self.outTF = UITextField
//      }
//      
//      // display the UIAlertController object
//      present(alert, animated: true, completion: nil)
//
//    }
}

//composeVC.addAttachmentData(Data, mimeType: String, fileName: String)







/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */




/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


