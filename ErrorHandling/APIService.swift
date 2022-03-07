//
//  APIService.swift
//  ErrorHandling
//
//  Created by Admin on 27/01/22.
//

import UIKit

class APIService: NSObject {
    
    func getApiData(str:String,completion:@escaping([User])->()){
        if let url = URL(string: str){
            let requst = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: requst) { dataFromServer, respo, err in
                print(dataFromServer)
                guard let data = dataFromServer else {
                    return
                }

                do
                { let userData = try JSONDecoder().decode([User].self, from: data)
                    completion(userData)
                }
                catch {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}
