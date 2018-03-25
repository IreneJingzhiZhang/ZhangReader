//
//  XMLDetailView.swift
//  ZhangReader
//
//  Created by Jingzhi Zhang on 9/26/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//  Purpose: To show the selected client's detailed information.


import UIKit

class XMLDetailView: UIViewController {
    
    // Markup: Outlets
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientProfession: UILabel!
    @IBOutlet weak var clientDob: UILabel!
    @IBOutlet weak var clientChildren: UITextView!
    
    // Markup: Variables
    var nameString: String!
    var professionString: String!
    var dobString: String!
    var childrenString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show the client's detailed information
        clientName.text = nameString
        clientProfession.text = professionString
        clientDob.text = dobString
        if childrenString.isEmpty{
            clientChildren.text = "Doesn't have any children"
        }
        else{
        clientChildren.text = childrenString
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
