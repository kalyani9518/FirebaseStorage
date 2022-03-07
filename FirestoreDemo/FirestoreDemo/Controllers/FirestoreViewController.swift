//
//  FirestoreViewController.swift
//  FirestoreDemo
//
//  Created by Admin on 25/02/22.
//

import UIKit

class FirestoreViewController: UIViewController {
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tblView: UITableView!
var posts = [postStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        FireStoreViewModel().getdata { users in
            self.posts = users
            self.indicator.stopAnimating()
            self.tblView.isHidden = false
            self.tblView.reloadData()
        }
    }
    

}
extension FirestoreViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tblView.dequeueReusableCell(withIdentifier: "FirestoreTableViewCell", for: indexPath) as? FirestoreTableViewCell{
            
            if indicator.isAnimating == false{
                indicator.isHidden = true
                cell.posts = post
                return cell
            }}
        return UITableViewCell()
    }
    
    
}
