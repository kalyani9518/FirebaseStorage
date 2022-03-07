//
//  HomeViewController.swift
//  ReviseGADemo
//
//  Created by Admin on 23/02/22.
//

import UIKit
import FirebaseCrashlytics
import FirebaseDatabase
class HomeViewController: UIViewController {
    @IBOutlet weak var uid: UITextField!
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userMobileNo: UITextField!
    
    let database = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    @IBAction func saveBtn(_ sender: Any) {
        if uid.text?.isEmpty == true || userEmail.text?.isEmpty == true || userName.text?.isEmpty == true{
            showAlert(title: "Warning", message: "Please enter the All detail")
        }else{
            database.child("user").child(uid.text!).setValue(["name":userName.text,"contactEmail":userEmail.text,"contactNo":userMobileNo.text])
        if let viewcontrollerObj = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController{
            self.navigationController?.pushViewController(viewcontrollerObj, animated: true)
        }
        }
       
    }
    func showAlert (title:String,message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }

}
