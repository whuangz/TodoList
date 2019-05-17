//
//  DetailDescriptionVC.swift
//  ToDo-List
//
//  Created by William Huang on 8/26/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit

class DetailDescriptionVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var descLblDesc: UILabel!
    
    var todoItem:ToDo?
    
    var titleBar: String = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeBackButton()
        
        self.navigationItem.title = titleBar
        self.descLblDesc.text = todoItem?.descriptionToDo
        
        swipeLeft()
        // Do any additional setup after loading the view.
    }
    
    func removeBackButton(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipeLeft(){
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(DetailDescriptionVC.swipeToToDo(sender:)))
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    
    func swipeToToDo(sender: UISwipeGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
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
