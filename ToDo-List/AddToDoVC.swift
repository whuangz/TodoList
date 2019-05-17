//
//  AddToDoVC.swift
//  ToDo-List
//
//  Created by William Huang on 8/26/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import CoreData

class AddToDoVC: UIViewController, UIGestureRecognizerDelegate, UITextViewDelegate {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    
    let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor

    var toDO = [ToDo]()
    var managedObjectContext: NSManagedObjectContext!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        
        self.navigationItem.title = "Create a new To-Do"
        
        
        
        
       
        descriptionTxt.layer.borderColor = color
        descriptionTxt.layer.borderWidth = 1.0
        descriptionTxt.layer.cornerRadius = 5
        
        //swipeLeft()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func hideKeyboarDelegate(){
        //hidewillkeyboard
        self.descriptionTxt.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddToDoVC.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddToDoVC.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func updateTextView(notification: Notification){
        let userInfo = notification.userInfo!
        
        let keyboardEndFrameScreenCoordinate = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinate, to: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            descriptionTxt.contentInset = UIEdgeInsets.zero
        }else {
            descriptionTxt.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
            
            descriptionTxt.scrollIndicatorInsets = descriptionTxt.contentInset
        }
        
        descriptionTxt.scrollRangeToVisible(descriptionTxt.selectedRange)
    }
    
    @IBAction func createtodo(_ sender: Any){

        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let toDoItem = ToDo(context: managedObjectContext)
        
        if titleTxt.text != "" {
            toDoItem.title = titleTxt.text
            toDoItem.descriptionToDo = descriptionTxt.text
            
            do {
                try self.managedObjectContext.save()
            }catch {
                print("Could not save data \(error.localizedDescription)")
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func swipeLeft(){
        let swipeLeft = UIGestureRecognizer(target: self, action: #selector(AddToDoVC.swipeToToDo(sender:)))
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func swipeToToDo(sender: UISwipeGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
