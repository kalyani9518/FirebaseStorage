import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase
import FirebaseDatabase

class GoogleSignInViewController: UIViewController{
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    @IBOutlet weak var phoneNoText: UITextField!
         @IBOutlet weak var otpText: UITextField!
         var verification_Id :String? = nil
    var user : GIDGoogleUser?
    let database  = Database.database().reference()
    var viewModelClass = ViewModelClass()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login with Email"
        indicator.startAnimating()
        otpText.isHidden = true
        database.child("user").childByAutoId().setValue(["name":"kalyani","lastName":"Mhase"])
        if Auth.auth().currentUser != nil {
           // self.navigate()
        }
    
}
    @IBAction func btnAction(_ sender: Any) {
        viewModelClass.googleSignIn(viewcontroller: self) {
            
            
        }
        
    }
    func navigate(){
        if let googleVC = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController{
            self.navigationController?.pushViewController(googleVC, animated: true)
        }
    }
    
    @IBAction func nextToVc(_ sender: Any) {
      //  if let signInViewController =  storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController{
           // self.navigationController?.pushViewController(signInViewController, animated: true)
        //}
    }
    
    @IBAction func googleBtnAction(_ sender: Any){
        if otpText.isHidden {
            if !phoneNoText.text!.isEmpty {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNoText.text ?? "", uiDelegate: nil) { (verificationID, error) in
                    if error != nil {
                        self.showAlert(title: "", message: "Please enter valid Phone Number")
                    } else {
                        self.verification_Id = verificationID
                        self.otpText.isHidden = false
                    }
                }
            }else {
                showAlert(title: "", message: "Please enter Phone Number")
            }
        } else {
            if verification_Id != nil {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_Id!, verificationCode: otpText.text!)
                Auth.auth().signIn(with: credential) { (authData, error) in
                    if error != nil {
                        self.showAlert(title: "", message: "OPT is invalid")
                    } else {
                        //self.showAlert(title: "", message: "Login Succesful with" +  (authData?.user.phoneNumber ?? ""))
                        let userID = authData?.user.uid
                        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController{
                            
                            viewController.userID = userID
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    }
                }
            }else {
            }
        }
    }
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
