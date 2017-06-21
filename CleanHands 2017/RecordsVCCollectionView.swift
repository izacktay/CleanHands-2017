//
//  RecordsVCCollectionView.swift
//  CleanHands 2017
//
//  Created by Izack on 7/6/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class RecordsVCCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate {
    
    let dc = DataController.sharedInstance
    
    @IBOutlet weak var outCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        outCollectionView.delegate = self
        outCollectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dc.recordArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! RecordsCollectionViewCell
        
        let item = indexPath.item
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let date = dc.recordArr[item].date
        let dateFormatted = dateFormatter.string(from: date)
        
        
        cell.outTitleLabel.text = dateFormatted
        cell.outImageView.image = UIImage(named: "mountains.jpg")
        
        return cell
    }
    
    @IBAction func actSend(_ sender: UIBarButtonItem) {
        
        
        let mailComposeViewController = configuredMailComposeViewController()
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["nurdin@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposerVC, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
//        let fileName = "Data.csv"
//        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
//        
//        var csvText = "\(fileName)"
//        
//        do {
//            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
//            
//            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
//            vc.excludedActivityTypes = [
//                UIActivityType.assignToContact,
//                UIActivityType.saveToCameraRoll,
//                UIActivityType.postToFlickr,
//                UIActivityType.postToVimeo,
//                UIActivityType.postToTencentWeibo,
//                UIActivityType.postToTwitter,
//                UIActivityType.postToFacebook,
//                UIActivityType.openInIBooks,
//                UIActivityType.mail
//            ]
//            present(vc, animated: true, completion: nil)
//            
//        } catch {
//            
//            print("Failed to create file")
//            print("\(error)")
//        }
        
    }
    
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["nurdin@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func showSendMailErrorAlert() {
        let mailError = UIAlertController()
        mailError.title = "Could Not Send Email"
        mailError.message = "Your device could not send e-mail.  Please check e-mail configuration and try again."
        let okAction = UIAlertAction(title:"OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil)
        mailError.addAction(okAction)
        
        present(mailError, animated: true, completion: nil)
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
