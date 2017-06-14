//
//  MomentsTVC.swift
//  CleanHands 2017
//
//  Created by Izack on 13/6/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class MomentsTVC: UITableViewController {
    
    let dc = DataController.sharedInstance
    var momentsArr : [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         momentsArr = ["Before Contact", "After Contact", "Before Exposure", "After Exposure", "After Environment"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return momentsArr.count
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        var moments = ""
        
        if (row == 0){
            moments = "Before Contact"
        }else if (row == 1){
            moments = "After Contact"
        }else if (row == 1){
            moments = "Before Exposure"
        }else if (row == 1){
            moments = "After Exposure"
        }else {
            moments = "After Environment"
        }
        
        dc.moments = moments
        performSegue(withIdentifier: "fromMoments", sender: self)
        
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let row = indexPath.row
        if let label = cell.textLabel{
            label.text = momentsArr[row]
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

}
