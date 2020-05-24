//
//  TodoTableViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/05/22.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

class TodoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true

        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Realmをインスタンス化して使えるようにする
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)
        
        return todos.count
    }

    
    //withIdentifierを設定した名前に合わせる
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

//         Configure the cell...
        
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.text
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    //データ削除設定
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let realm = try! Realm()
            let todos = realm.objects(Todo.self)
            let todo = todos[indexPath.row]
            
            try! realm.write {
                realm.delete(todo)
            }
            
            
            
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
//
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//         return .none
//    }

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    
    @IBAction func tapAddButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Todoを追加しますか？", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "追加", style: .default){
            (void) in
            let textField = alertController.textFields![0] as UITextField
            if let text = textField.text {
                
                let todo = Todo()
                todo.text = text
                
                //Realmをインスタンス化して使えるようにする
                let realm = try! Realm()
                // Persist your data easily 永続化
                try! realm.write {
                    realm.add(todo)
                }
                
                self.tableView.reloadData()
                
            }
            
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alertController.addTextField{(textField) in
            textField.placeholder = "Todoの名前を入れてください。"
            
        }
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)

    
    }
    
    
    
    
    
    
    
    
    
    
}
