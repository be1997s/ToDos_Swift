//
//  AddViewController.swift
//  ToDo
//
//  Created by BE X on 02/05/1443 AH.
//

import UIKit

class AddViewController:UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
var  iscreateScreen = true
    var editTodo : Todo?
    var editIndex : Int?
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var imgButton: UIButton!
    @IBOutlet weak var imagrTodo: UIImageView!
    @IBOutlet weak var addbutton: UIButton!
    @IBOutlet weak var detailsText: UITextView!
    @IBOutlet weak var TitleText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgButton.layer.cornerRadius =  10
        addbutton.layer.cornerRadius =  10
        detailsText.layer.cornerRadius =  10
        if !iscreateScreen  {
            imgButton.setTitle("تعديل الصورة", for: .normal)
            addbutton.setTitle("تعديل", for : .normal)
            navigationItem.title = "تعديل المهمة"
            if let todo = editTodo {
                TitleText.text = todo.title
                detailsText.text = todo.details
                imagrTodo.image = todo.img
            }
            
        }
        imagePicker.delegate = self

    }
    @IBAction func TodoImg(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagrTodo.contentMode = .scaleAspectFit
            imagrTodo.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
 

    @IBAction func AddButton(_ sender: Any) {
        if iscreateScreen {
            if TitleText.text != "" {
                var add = Todo(title: TitleText.text!,img: imagrTodo.image,details:detailsText.text,date: Date())
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addTodo"), object: nil,userInfo: ["addTodo" : add])
                
                let alert = MyAlertViewController(
                    title:  "تنبيه",
                    message: "لقد تم اضافة مهمة جديدة!",
                    imageName: "check")
                alert.addAction(title: "حسناً", style: .default, handler: { _ in  self.tabBarController?.selectedIndex = 0})
                self.present(alert, animated: true,completion: {
                    self.TitleText.text = nil
                    self.detailsText.text = nil
                   
                })} else {
                    let alert = MyAlertViewController(
                        title:  "تنبيه",
                        message: "الرجاء ادخال العنوان",
                        imageName: "warning-sign")
                    alert.addAction(title: "حسناً", style: .default)
                                self.present(alert, animated: true,completion: {
                                })
        }
        } else {
            if TitleText.text != "" {
                let edit = Todo(title: TitleText.text!,img: imagrTodo.image,details:detailsText.text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "editTodo"), object: nil,userInfo: ["editTodo" : edit,"index":editIndex])
            
                let alert = MyAlertViewController(
                    title:  "تنبيه",
                    message: "لقد تم تعديل المهمة بنجاح!",
                    imageName: "check")
                alert.addAction(title: "حسناً", style: .default,handler: { _ in  self.navigationController?.popViewController(animated: true )})
            self.present(alert, animated: true,completion: {
                self.TitleText.text = nil
                self.detailsText.text = nil
                self.iscreateScreen = true
            })
            } else {
                let alert = MyAlertViewController(
                    title:  "تنبيه",
                    message: "الرجاء ادخال العنوان",
                    imageName: "warning-sign")
                alert.addAction(title: "حسناً", style: .default)
                self.present(alert, animated: true,completion: {
                })
}
        }

        }
    
    
  
    
}
