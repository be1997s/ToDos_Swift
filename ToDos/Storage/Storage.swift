//
//  Storage.swift
//  ToDo
//
//  Created by BE X on 04/05/1443 AH.
//

import UIKit
import CoreData

class Storage {
    //Store Data in CoreData
    func store(todos : Todo) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {return}
        let manageContex = appDelegate.persistentContainer.viewContext
        guard let TodoEntity = NSEntityDescription.entity(forEntityName: "Todos", in: manageContex) else { return }
        let todo = NSManagedObject.init(entity: TodoEntity, insertInto: manageContex)
        todo.setValue(todos.title, forKey: "title")
        todo.setValue(todos.details, forKey: "details")
        todo.setValue(todos.date, forKey: "date")
        if let image = todos.img{
            let imgData = image.pngData()
            todo.setValue(imgData, forKey: "image")
        }
        do{
            try manageContex.save()
            print(",")}
            catch {
            print("error in save data")
        }
        
    }
    
    //update Data in CoreData
    func update(todos : Todo,index:Int){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {return}
    let manageContex = appDelegate.persistentContainer.viewContext
    let fetchRequast = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
    do{
        let resualt =  try manageContex.fetch(fetchRequast ) as! [NSManagedObject]
        resualt[index].setValue(todos.title, forKey: "title")
        resualt[index].setValue(todos.details, forKey: "details")
        if let image = todos.img{
            let imgData = image.pngData()
            resualt[index].setValue(imgData, forKey: "image")
        }
        try manageContex.save()
       
    } catch{
        print("error in save data2")

    }
}
    
    
    //delete Data in CoreData
    func delete(index:Int){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {return}
    let manageContex = appDelegate.persistentContainer.viewContext
    let fetchRequast = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
    do{
       let test = try manageContex.fetch(fetchRequast)
       let objectdelete = test[index] as! NSManagedObject
        manageContex.delete(objectdelete)
        do{
            try manageContex.save()}
       
    } catch{
        print("error in save data3")

    }
}
    
    //get Data from CoreData
    func getTodo() -> [Todo] {
        var todos: [Todo] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {return []}
        let manageContex = appDelegate.persistentContainer.viewContext
        let fetchRequast = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        do{
            let resualt =  try manageContex.fetch(fetchRequast ) as! [NSManagedObject]
            for item in resualt {
                var titlee = item.value(forKey:"title")
                let detailss = item.value(forKey:"details")
                
                var todoDate : Date?
                if let datte = item.value(forKey: "date") as? Date {
                    todoDate = datte
                }
                
                var todoImage : UIImage?
                if let image = item.value(forKey: "image") as? Data {
                    todoImage = UIImage(data: image)
                }
                
                
                let toddo = Todo(title: titlee as! String, img: todoImage , details: detailss as? String,date: todoDate)
                
                todos.append(toddo)
                
                 
            }
        }catch{
            print("error in save data2")

        }
        return todos
    }
 
}
