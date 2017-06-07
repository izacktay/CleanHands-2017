//
//  RecordsCollectionViewVC.swift
//  CleanHands 2017
//
//  Created by Izack on 7/6/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit
import MessageUI

class RecordsCollectionViewVC: UIViewController, MFMailComposeViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let dc = DataController.sharedInstance
    
    
    @IBOutlet weak var outCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail service not available")
            return
            
            
        }
        print("test")
        outCollectionView.delegate = self
        outCollectionView.dataSource = self
        
        if let cv = self.outCollectionView {
            cv.allowsMultipleSelection = true
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath)
        
        cell.backgroundColor = UIColor.gray
        
        return cell
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actSend(_ sender: UIBarButtonItem) {
        
        let fileName = "Data.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        var csvText = "\(fileName)"
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            
            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
            vc.excludedActivityTypes = [
                UIActivityType.assignToContact,
                UIActivityType.saveToCameraRoll,
                UIActivityType.postToFlickr,
                UIActivityType.postToVimeo,
                UIActivityType.postToTencentWeibo,
                UIActivityType.postToTwitter,
                UIActivityType.postToFacebook,
                UIActivityType.openInIBooks,
                UIActivityType.mail
            ]
            present(vc, animated: true, completion: nil)
            
        } catch {
            
            print("Failed to create file")
            print("\(error)")
        }
        
    }
    
    
    
    
    
}
//        print("Hi")
//        //sendEmail()
//        let composeVC = MFMailComposeViewController()
//        composeVC.mailComposeDelegate = self
//        composeVC.setToRecipients(["15017612@myrp.edu.sg"])
//        composeVC.setSubject("'Sup")
//        composeVC.setMessageBody("Testing", isHTML: false)
//
//        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(nibName!)
//
//        composeVC.addAttachmentData(NSData(contentsOf: path!)! as Data, mimeType: "text/csv", fileName: "Data.csv")
//        present(composeVC, animated: true, completion: nil)
//
//
//        do {
//            try composeVC.writeToURL(path, atomically: true, encoding: NSUTF8StringEncoding)
//
//            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
//            present(vc, animated: true, completion: nil)
//            vc.excludedActivityTypes = [
//                UIActivityType.assignToContact,
//                UIActivityType.mail,
//                UIActivityType.saveToCameraRoll,
//                UIActivityType.postToFlickr,
//                UIActivityType.postToVimeo,
//                UIActivityType.postToTencentWeibo,
//                UIActivityType.postToTwitter,
//                UIActivityType.postToFacebook,
//                UIActivityType.openInIBooks
//            ]
//            present(vc, animated: true, completion: nil)
//
//        } catch {
//
//            print("Failed to create file")
//            print("\(error)")
//        }
//
//    }


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



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */



//extension MFMailComposeViewControllerDelegate {
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//
//}
