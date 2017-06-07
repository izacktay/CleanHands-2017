//
//  SettingsVC.swift
//  CleanHands 2017
//
//  Created by Izack on 30/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var outSwitch: UISwitch!
    
    @IBAction func actDone(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSettings", sender: self)
    }
    
    @IBAction func actSwitch(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "switchState")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outSwitch.isOn =  UserDefaults.standard.bool(forKey: "switchState")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rTVC = segue.destination as! RecordsTVC
        if (outSwitch.isOn == true){
            rTVC.switchString = "true"
            rTVC.switchState = true
        }else if (outSwitch.isOn == false){
            rTVC.switchString = "false"
            rTVC.switchState = false
        }
    }
    

}
