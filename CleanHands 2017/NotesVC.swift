//
//  NotesVC.swift
//  CleanHands 2017
//
//  Created by Izack on 9/5/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {
    
    let dc = DataController.sharedInstance
    
    @IBOutlet weak var outTFTitle: UITextField!
    @IBOutlet weak var outTVNotes: UITextView!
    
    var segueIdentifier = ""
    
    let myDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outTVNotes.layer.borderWidth = 1
        outTVNotes.layer.cornerRadius = 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(false)
        outTFTitle.text = myDefaults.string(forKey: "title")
        outTVNotes.text = myDefaults.string(forKey: "text")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        let notesTitle = outTFTitle.text!
        let notesText = outTVNotes.text!
        
        myDefaults.set(notesTitle, forKey: "title")
        myDefaults.set(notesText, forKey: "text")
        
    }
    
    @IBAction func actSave(_ sender: UIBarButtonItem) {
        
        
        
        performSegue(withIdentifier: "unwindNotes", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    
    
}
