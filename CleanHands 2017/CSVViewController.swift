//
//  CSVViewController.swift
//  CleanHands 2017
//
//  Created by Justin Chong on 24/5/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit
import MessageUI

class CSVViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail service not available")
            return
            
            
        }

        // Do any additional setup after loading the view.
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
               controller.dismiss(animated: true, completion: nil)
           }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actSend(_ sender: UIBarButtonItem) {
        print("Hi")
        //sendEmail()
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["15017612@myrp.edu.sg"])
        composeVC.setSubject("'Sup")
        composeVC.setMessageBody("Testing", isHTML: false)
        
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(nibName!)
        
        composeVC.addAttachmentData(NSData(contentsOf: path!)! as Data, mimeType: "text/csv", fileName: "Data.csv")
        present(composeVC, animated: true, completion: nil)
        
        
        
        
        
//        if let filePath = Bundle.main.path(forResource: "swifts", ofType: "csv") {
//            print("File path loaded.")
//            
//            if let fileData = NSData(contentsOfFile: filePath) {
//                print("File data loaded.")
//                composeVC.addAttachmentData(fileData as Data, mimeType: "audio/wav", fileName: "swifts")
//            }
//        }
//        self.present(composeVC, animated: true, completion: nil)
//        
//        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
//        
//        let csvFileName = documentsPath.stringByAppendingPathComponent("Data.csv")
//        let fileData = NSData(contentsOfFile: csvFileName)
//        composeVC.addAttachmentData(fileData, mimeType: "application/csv", fileName: Data)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension MFMailComposeViewControllerDelegate {
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//    
//}
