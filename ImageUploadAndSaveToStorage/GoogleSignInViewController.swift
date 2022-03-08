import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase

class GoogleSignInViewController: UIViewController{
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    @IBOutlet weak var phoneNoText: UITextField!
         @IBOutlet weak var otpText: UITextField!
         var verification_Id :String? = nil
    
    
    var viewModelClass = ViewModelClass()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login with Email"
        indicator.startAnimating()
        otpText.isHidden = true
        if Auth.auth().currentUser != nil {
            self.navigate()
        }
    
}
    @IBAction func btnAction(_ sender: Any) {
        viewModelClass.googleSignIn(viewcontroller: self) {
            self.navigate()
        }
        
    }
    func navigate(){
        if let googleVC = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController{
            self.navigationController?.pushViewController(googleVC, animated: true)
        }
    }
    
    @IBAction func nextToVc(_ sender: Any) {
        if let signInViewController =  storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController{
            self.navigationController?.pushViewController(signInViewController, animated: true)
        }
    }
    
    @IBAction func googleBtnAction(_ sender: Any){
        if otpText.isHidden {
            if !phoneNoText.text!.isEmpty {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNoText.text ?? "", uiDelegate: nil) { (verificationID, error) in
                    if error != nil {
                        return
                    } else {
                        self.verification_Id = verificationID
                        self.otpText.isHidden = false
                    }
                }
            }else {
                print("Please Enter your phone number")
            }
        } else {
            if verification_Id != nil {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_Id!, verificationCode: otpText.text!)
                Auth.auth().signIn(with: credential) { (authData, error) in
                    if error != nil {
                        print(error.debugDescription)
                    } else {
                        let alert = UIAlertController(title: "", message: "Login Succesful with" +  (authData?.user.phoneNumber ?? ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }else {
            }
        }
    }
}
