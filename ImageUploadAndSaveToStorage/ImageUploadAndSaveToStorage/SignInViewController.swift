//
//  GoogleViewController.swift
//  ImageUploadAndSaveToStorage
//
//  Created by Admin on 08/03/22.
//

import UIKit

class SignInViewController: UIViewController {
    var userId :String?
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signInBtn: UIButton!
    
    var userViewModel: ViewModelClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login with Email"
        self.userViewModel = ViewModelClass()
        userViewModel?.restorePreviouslyLogin(complisherHandler: {[weak self] in
            
        })
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        self.activityIndicator.startAnimating()
        self.signInBtn.isEnabled = false
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        userViewModel?.loginUser(withEmail: email, password: password) {[weak self] in
            DispatchQueue.main.async {
                self?.signInBtn.isEnabled = true
                self?.activityIndicator.stopAnimating()
                self!.showAlert(title: "Alert", message: "Login successFully")
                
            }
        }
    }
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        if let signUpViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            signUpViewControllerObj.userId = userId
            navigationController?.pushViewController(signUpViewControllerObj, animated: true)
        }
    }
    
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
