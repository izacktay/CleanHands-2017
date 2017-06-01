//
//  RecordsCollectionViewVC.swift
//  CleanHands 2017
//
//  Created by Izack on 31/5/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class RecordsCollectionViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    let dc = DataController.sharedInstance
    
    @IBOutlet weak var outCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        outCollectionView.delegate = self
        outCollectionView.dataSource = self
        if let cv = self.outCollectionView {
            cv.allowsMultipleSelection = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dc.observationArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath)
        
        cell.backgroundColor = UIColor.gray
        
        return cell
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
