//
//  ViewModel.swift
//  FirestoreDemo
//
//  Created by Admin on 25/02/22.
//

import Foundation

import FirebaseFirestore
class FireStoreViewModel{
    
    var users = [postStruct]()
    
    func getdata(completion:@escaping((_ users:[postStruct])->())){
        let db = Firestore.firestore()
        db.collection("users").whereField("check", isEqualTo: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {                      print("\(document.documentID) => \(document.data())")
                        let data = document.data()
                        let name =  data["name"] as? String
                        let email = data["email"] as? String
                        let mobileNo = data["mobileNo"] as? String
                        let user = postStruct(name: name!, email: email!, mobileNo: mobileNo!)
                        self.users.append(user)
                      
                        DispatchQueue.main.async {
                            completion(self.users)
                        }

                }
                    }
                }
        
    }
}
