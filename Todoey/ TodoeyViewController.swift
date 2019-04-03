//
//  ViewController.swift
//  Todoey
//
//  Created by Hunter Akers on 4/3/19.
//  Copyright © 2019 ElCasador. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {

    let itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}

