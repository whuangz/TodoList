//
//  TodoVC.swift
//  ToDo-List
//
//  Created by William Huang on 8/26/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import CoreData

class TodoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var toDO = [ToDo]()
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My To-Do"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Do any additional setup after loading the view.
    }
    
    func refresh(){
        self.loadData()
        todoTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    
    func loadData(){
        let todoRequest:NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        do{
            toDO = try managedObjectContext.fetch(todoRequest)
        }catch{
            print("Cound not load data from DB \(error.localizedDescription)")
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoTableViewCell
        
        cell.titleLbl.text = "😩 \(toDO[indexPath.row].title!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let deletedFile = toDO[indexPath.row]
            
            toDO.remove(at: indexPath.row) // array of objects that we are selecting
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            managedObjectContext.delete(deletedFile)
            do {
                try self.managedObjectContext.save()
            }catch {
                print("Could not delete data \(error.localizedDescription)")
            }
            
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showToDo" {
            if let destination = segue.destination as? DetailDescriptionVC {
                let index = todoTableView.indexPathForSelectedRow?.row
                
                    let toDoItem = toDO[index!]
                
                    destination.titleBar = toDoItem.title!
                    destination.todoItem = toDoItem
                
            }
        }
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
