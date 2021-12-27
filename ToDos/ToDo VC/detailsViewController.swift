//
//  detailsViewController.swift
//  ToDo
//
//  Created by BE X on 29/04/1443 AH.
//

import UIKit
// 
class detailsViewController: UIViewController {
    var todo : Todo!
    var index : Int!
    @IBOutlet weak var delButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.layer.cornerRadius =  10
        delButton.layer.cornerRadius =  10
        
        imgView.layer.cornerRadius =  8
        imgView.layer.borderWidth = 3
        imgView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imgView.clipsToBounds = true

        if todo.img != nil {        imgView.image = todo.img
        } else {imgView.image = UIImage(named: "Asset 1")}
        details.text = todo.details
        todoTitle.text = todo.title
        
        NotificationCenter.default.addObserver(self, selector: #selector(editTodo), name: NSNotification.Name(rawValue: "editTodo"), object: nil)
    }
    @objc func editTodo(  notification :   Notification){
        let index = notification.userInfo?["index"] as? Int
        if let  myTodo = notification.userInfo?["editTodo"] as? Todo {
            todo = myTodo
            details.text = todo.details
            todoTitle.text = todo.title
            imgView.image = todo.img
            
        }
    }
    
@IBAction func edit(_ sender: Any) {
      if  let vc = storyboard?.instantiateViewController(identifier: "edit") as? AddViewController
      {
        vc.iscreateScreen = false
        vc.editTodo = todo
        vc.editIndex = index
        navigationController?.pushViewController(vc, animated: true)
        
      }
    
        
    }
    
    @IBAction func deleteTodo(_ sender: Any) {
        
        let alert = MyAlertViewController(
            title: "تنبيه",
            message: "هل انت متاكد من الحذف؟",
            imageName:"warning-sign")

        alert.addAction(title: "موافق", style: .default , handler: {_ in ()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "delete"), object: nil,userInfo: ["index" : self.index])
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(title: "الغاء", style: .cancel)

        present(alert, animated: true, completion: nil)
        
 
        
    }
}
