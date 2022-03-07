//
//  ViewModel.swift
//  ImageUploadAndSaveToStorage
//
//  Created by Admin on 04/03/22.
//

import Foundation
import FirebaseStorage
class viewModelClass{
    let storageRef = Storage.storage().reference()
    var imageArr: [Data] = [Data]()
    var url = [URL]()
    func downLoadingImage(completion:@escaping(_ imageArr:[Data],_ url:[URL])->()){
        storageRef.child("Document").listAll { storeReference, error in
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
    func uploadFile(myURL:URL,extensionStr:String){
        storageRef.child("Document").child(UUID().uuidString + extensionStr).putFile(from: myURL, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
            return
            }
    }
        }
}
