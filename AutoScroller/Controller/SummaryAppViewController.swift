//
//  SummaryAppViewController.swift
//  AutoScroller
//
//  Created by Aria Bisma Wahyutama on 26/06/19.
//  Copyright © 2019 SHUBHAM AGARWAL. All rights reserved.
//

import UIKit

class SummaryAppViewController: UIViewController {

    var label = ""
    
    @IBOutlet weak var labelSummary: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSummary.text = label
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
