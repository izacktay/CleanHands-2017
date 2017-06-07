//
//  RecordsVCCollectionView.swift
//  CleanHands 2017
//
//  Created by Izack on 7/6/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class RecordsVCCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
