//
//  ViewController.swift
//  Todoey
//
//  Created by Hunter Akers on 4/3/19.
//  Copyright © 2019 ElCasador. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Bananas"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Carrots"
        itemArray.append(newItem3)
        
        //Sets the Saved Data from the phone
        //The if let statement is to protect the app from a situation when no default array is present
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {

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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }

    //MARK - TableView Delegate Methods
    
    //Selects the row when clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row]) TESTING PURPOSES
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        //This will add/remove a checkmark when the item is selected.
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }

        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
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

