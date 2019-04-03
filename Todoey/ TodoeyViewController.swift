//
//  ViewController.swift
//  Todoey
//
//  Created by Hunter Akers on 4/3/19.
//  Copyright © 2019 ElCasador. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets the Saved Data from the phone
        //The if let statement is to protect the app from a situation when no default array is present
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            
            itemArray = items
            
        }
        
    }
    
   
    
    //MARK - Table Datasource Methods
    
    //Sets the number of rows the table has based on the amount of information in the Array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //Creates the cell, Sets the label in the cell to the proper item in the Array, and returns the cell to the screen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    //MARK - TableView Delegate Methods
    
    //Selects the row when clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row]) TESTING PURPOSES
        
        //This will add/remove a checkmark when the item is selected.
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        
        //Deselects the row like a push-button would work
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add New Items
    
    //This is the plus @top right corner. It's called a Bar Button and the System Item is set to "Add" on the Attributes selector
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //Creates the alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when the user clicks the Add Item on the UIAlert PopUp
            
            self.itemArray.append(textField.text!)
            
            //save the information appened to the array in the USER DEFAULTS for presistance data storage
            //This does not make the data display on loading though. It is performed in initial ViewDidLoad
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //must reload data once alert is completed to complete action
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}

