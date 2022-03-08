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

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnteredPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUnBtn: UIButton!
    
    var userViewModel: ViewModelClass?
    
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
        userViewModel?.registerNewUser(withEmail: email, password: password, name: name) { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.showAlert(title: "Success", message: "Create new successfully")
                self?.signUnBtn.isEnabled = true
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
