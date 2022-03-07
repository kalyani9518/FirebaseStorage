//
//  ViewModel.swift
//  ReviseGADemo
//
//  Created by Admin on 24/02/22.
//

import Foundation
import Firebase
import FirebaseDatabase
class FirebaseViewModel{
    var posts = [postStruct]()
    
    func getPosts(completion:@escaping((_ posts:[postStruct])->())) {
        let databaseRef = Database.database().reference()
        databaseRef.child("user").queryOrderedByKey().observe( .childAdded, with: {
            snapshot in
            let name = (snapshot.value as? NSDictionary)!["name"] as? String
            let contactEmail = (snapshot.value as? NSDictionary
            )!["contactEmail"] as? String
            let contactNo = (snapshot.value as? NSDictionary
            )!["contactNo"] as? String
            
            self.posts.append(postStruct(name: name,contactEmail:contactEmail, contactNo:contactNo))
            DispatchQueue.main.async {
                completion(self.posts)
            }
        })
    }
    
    
}
