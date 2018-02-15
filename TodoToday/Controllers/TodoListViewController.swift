//
//  ViewController.swift
//  TodoToday
//
//  Created by Daniel Krupenin on 14.02.2018.
//  Copyright © 2018 Daniel Krupenin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
   
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        var newItem = Item()
        newItem.done = true
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        var newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        var newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
       
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new TodoToday Item",message: "", preferredStyle: .alert)
        let action = UIAlertAction(title:"Add Item", style: . default) {(action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
        }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
    alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

func saveItems() {
    let encoder = PropertyListEncoder()
    do{
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    }catch{
        print("Error encoding item array, \(error)")
    }
    
    self.tableView.reloadData()

}
    func loadItems(){
        if let data = try?Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
           itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
        }
    }
}













