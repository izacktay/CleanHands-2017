//
//  MainMenuViewController.swift
//  CleanHands 2017
//
//  Created by Justin Chong on 24/5/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var outStart: UIButton!
    
    let transition = CircularTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "records"){
            let vc = segue.destination as! RecordsTVC
            vc.transitioningDelegate = self
            vc.modalPresentationStyle = .custom
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = outStart.center
        transition.circleColor = outStart.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = outStart.center
        transition.circleColor = outStart.backgroundColor!
        
        return transition
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
