//
//  ViewController.swift
//  TodoToday
//
//  Created by Daniel Krupenin on 14.02.2018.
//  Copyright © 2018 Daniel Krupenin. All rights reserved.
//

import UIKit
import  RealmSwift

class TodoListViewController: UITableViewController {
   
    var TodoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       if let item = TodoItems?[indexPath.row]{

        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
       }else{
        cell.textLabel?.text = "Not Items Added"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = TodoItems?[indexPath.row]{
            do{
            try realm.write {
            item.done = !item.done
            }
            }catch{
                print("Error saving donw status, \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new TodoToday Item",message: "", preferredStyle: .alert)
        let action = UIAlertAction(title:"Add Item", style: . default) {(action) in
            if let currentCategory = self.selectedCategory{
                do{
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    }
                    }catch{
                       print("Error saving items, \(error)")
                    }
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
    alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func loadItems(){
        TodoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        self.tableView.reloadData()
    }

}

extension TodoListViewController: UISearchBarDelegate{

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        TodoItems = TodoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
        }
    }
}












