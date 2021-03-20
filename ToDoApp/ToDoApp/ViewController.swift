//
//  ViewController.swift
//  ToDoApp
//
//  Created by MacBook on 3/17/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
 
    
   
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return  table
        
        
    }()
    var items = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editT))
    }
    @objc private func editT(){
        table.isEditing = !table.isEditing
    }
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "Новая Задача", message: "Добавить новую задачу!", preferredStyle: .alert)
        alert.addTextField{field in field.placeholder = "Напиши свой ToDoList"}
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { [weak self]_ in
            if let field = alert.textFields?.first{
                            if let text = field.text, !text.isEmpty{
                                print(text)
                                DispatchQueue.main.async {
                                    var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                                    
                                    currentItems.append(text)
                                    UserDefaults.standard.setValue(currentItems , forKey: "items")
                                    self?.items.append(text)
                                    self?.table.reloadData()
                                }
                            }
                            
                        }
            
        }))
        
        
        
         present(alert, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
     
        return cell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemss = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(itemss, at: destinationIndexPath.row)
        
    }
    
    
    
}
    
    


