import Firebase
import FirebaseFirestore
class ViewController: UIViewController {
    @IBOutlet weak var uid: UITextField!
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userMobileNo: UITextField!
    
    var users = [postStruct]()
    let db = Firestore.firestore()
    var arr = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        db.collection("users").document(uid.text!).setData(["name":userName.text,"email":userEmail.text,"mobileNo":userMobileNo.text,"check":true])
//
//
//        db.collection("users").whereField("check", isEqualTo: true)
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                        let data = document.data()
//                      let name =   (document.value(forKey: "name")) as? String
//                        let email = (document.value(forKey: "email")) as? String
//                        let mobileNo = (document.value(forKey: "mobileNo"))as? String
//                        let user = postStruct(name: name!, email: email!, mobileNo: mobileNo!)
//                        self.users.append(user)
//
//                }
//                    }
//                }
   // print(users)
    }
        
    
    @IBAction func saveAction(_ sender: Any) {
        db.collection("users").document(uid.text!).setData(["name":userName.text,"email":userEmail.text,"mobileNo":userMobileNo.text,"check":true])
        if let firestoreViewcontroller = storyboard?.instantiateViewController(withIdentifier: "FirestoreViewController") as? FirestoreViewController{
            self.navigationController?.pushViewController(firestoreViewcontroller, animated: true)
        }
       
        
        
    }
    
    
    
}

    

