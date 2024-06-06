//
//  PlannerViewController.swift
//  DemoAlzyCare
//
//  Created by Batch-2 on 03/06/24.
//

import UIKit

class PlannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.tabBarItem.title = "Planner"
        self.tabBarItem.image = UIImage(systemName: "calendar")
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
