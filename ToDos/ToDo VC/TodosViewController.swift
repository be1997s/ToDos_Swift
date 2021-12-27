//
//  TodosViewController.swift
//  ToDo
//
//  Created by BE X on 29/04/1443 AH.
//

import UIKit

class TodosViewController: UIViewController ,UITableViewDelegate {
    var todosArray: [Todo] = []
    let storage = Storage()
    @IBOutlet weak var todoList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todosArray = storage.getTodo()
        NotificationCenter.default.addObserver(self, selector: #selector(newToadd), name: NSNotification.Name(rawValue: "addTodo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(editTodo), name: NSNotification.Name(rawValue: "editTodo"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(del), name: NSNotification.Name(rawValue: "delete"), object: nil)
        
        todoList.dataSource = self
        todoList.delegate = self
        
    }
    @objc func newToadd(  notification :   Notification){
        if let  myTodo = notification.userInfo?["addTodo"] as? Todo {
            todosArray.append(myTodo)
            todoList.reloadData()
            storage.store( todos : myTodo)
        }
    }
    
    @objc func editTodo(  notification :   Notification){
        let index = notification.userInfo?["index"] as? Int
        if let  myTodo = notification.userInfo?["editTodo"] as? Todo {
            todosArray[index!] = myTodo
            todoList.reloadData()
            storage.update(todos : myTodo,index:index!)
        }
       
        
    }

    @objc func del(  notification :   Notification){
        let index = notification.userInfo?["index"] as? Int
        todosArray.remove(at: index!)
            todoList.reloadData()
        storage.delete(index:index!)
        }
        
    }
    


extension TodosViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoTableViewCell
        cell.todoTitle.text=todosArray[indexPath.row].title
        if (todosArray[indexPath.row].img != nil){
            cell.TodoImgView.image=todosArray[indexPath.row].img
        }else{
        cell.TodoImgView.image = UIImage(named: "Asset 1")
        }
        let time = todosArray[indexPath.row].date as? Date ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mma"
        let nowFormatted = dateFormatter.string(from: time)
        
        cell.TodoDate.text = nowFormatted
        
        cell.viewCel.layer.cornerRadius = cell.viewCel.frame.height / 2
        
        return cell
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todo = todosArray[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "detailsVc") as? detailsViewController
        if let vc2 = vc {
            vc2.todo = todo
            vc2.index = indexPath.row 
            navigationController?.pushViewController(vc2, animated: true)

        }
    }
    
    
    
    
   
}


