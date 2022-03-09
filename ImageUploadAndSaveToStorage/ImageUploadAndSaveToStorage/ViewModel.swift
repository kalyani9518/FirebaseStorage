//
//  ViewModel.swift
//  ImageUploadAndSaveToStorage
//
//  Created by Admin on 04/03/22.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import GoogleSignIn
import Firebase
class ViewModelClass{
    private(set) var user: User?
    var userModel : GoogleUserModel!
    let storageRef = Storage.storage().reference()
    var imageArr: [Data] = [Data]()
    var url = [URL]()
    func downLoadingImage(userID:String,completion:@escaping(_ imageArr:[Data],_ url:[URL])->()){
        storageRef.child(userID).child("Document").listAll { storeReference, error in
            for item in storeReference.items{
                let path = item.fullPath
                print(item.fullPath)
                self.storageRef.child(path).downloadURL { url, err in
                    guard let url = url else {
                        return
                    }
                    var urlLast = url.pathExtension
                    if (urlLast == "doc" || urlLast == "docx" || urlLast == "pdf" || urlLast == "xls"){
                        self.url.append(url)
                        print(url)
                    }
                    else{
                        URLSession.shared.dataTask(with: url) { data, respo, err in
                            DispatchQueue.main.async {
                                guard let data = data else {
                                    return
                                }
                                self.imageArr.append(data)
                                
                                
                                completion(self.imageArr, self.url)
                            }
                            
                        }.resume()
                    }
                }
            }
        }
        
    }
    func downloadingPdf(completion:@escaping(_ url : [URL])->()){
        storageRef.child("PDF_Files").listAll { storeReference, error in
            for item in storeReference.items{
                let path = item.fullPath
                print(item.fullPath)
                self.storageRef.child(path).downloadURL { url, err in
                    guard let url = url else {
                        return
                    }
                    
                    self.url.append(url)
                    completion(self.url)
                }
            }
        }
        
    }
    func restorePreviouslyLogin(complisherHandler:()->()) {
        if Auth.auth().currentUser != nil {
            guard let user = Auth.auth().currentUser else{
                return
            }
            self.user = user
            complisherHandler()
        }
    }
    func uploadFile(userID:String,myURL:URL,extensionStr:String){
        storageRef.child(userID).child("Document").child(UUID().uuidString + extensionStr).putFile(from: myURL, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                return
            }
        }
    }
    
    func googleSignIn(viewcontroller : UIViewController,completion:@escaping()->()){
        guard let clientID = FirebaseApp.app()?.options.clientID else{
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewcontroller) { [unowned self] user, error in
            if let error = error {
                
                return
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else {return}
            let userId = user?.userID
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error{
                    print(error.localizedDescription)
                }
                else{
                    guard let googleUser = authResult?.user else{
                        return
                    }
                    guard let email = googleUser.email,let phoneNo = googleUser.phoneNumber else{
                        return}
                    let googleUserObj = GoogleUserModel(userMail: email, userMobileNo: phoneNo)
                    self.userModel = googleUserObj
                    completion()
                }
            }
        }
    }
    func loginUser(withEmail email: String, password: String, complesherHandler:@escaping ()->()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] auth, error in
            if error == nil {
                print("successful Login")
                self?.user = auth?.user
                complesherHandler()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    func registerNewUser(withEmail email: String, password: String, name: String, complesherHandler:@escaping (_ user:User)->()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] auth, error in
            if error == nil {
                let changeRequest = auth?.user.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { [weak self] error in
                    print("Account Created")
                    self?.user = auth?.user
                    complesherHandler((self?.user)!)
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
