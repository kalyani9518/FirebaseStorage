//
//  SignUpViewController.swift
//  ImageUploadAndSaveToStorage
//
//  Created by Admin on 08/03/22.
//

//
//  SignUpViewController.swift
//  GoogleAuthUsingFCM
//
//  Created by Admin on 24/02/22.
//

import UIKit
import FirebaseDatabase
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnteredPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUnBtn: UIButton!
    var userId : String?
    var userViewModel: ViewModelClass?
    let database = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userViewModel = ViewModelClass()
    }
    @IBAction func signUpBtnAction(_ sender: Any) {
        self.activityIndicator.startAnimating()
        self.signUnBtn.isEnabled = false
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let name = nameTextField.text else {return}
        userViewModel?.registerNewUser(withEmail: email, password: password, name: name) { user  in
            DispatchQueue.main.async {
               // self?.database.child((self?.emailTextField.text)!).childByAutoId().setValue(["name":name,"contactEmail":email,"password":password])
                self.activityIndicator.stopAnimating()
                self.database.child(user.uid).childByAutoId().setValue(["name":name,"contactEmail":email,"password":password])
                self.showAlert(title: "Success", message: "Create new successfully")
                self.signUnBtn.isEnabled = true
                //  self?.navigateToHomePage()
            }
        }
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
