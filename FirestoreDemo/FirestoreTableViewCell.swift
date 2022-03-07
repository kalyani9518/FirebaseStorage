//
//  FirestoreTableViewCell.swift
//  FirestoreDemo
//
//  Created by Admin on 25/02/22.
//

import UIKit

class FirestoreTableViewCell: UITableViewCell {

    @IBOutlet weak var mobileNoOutlet: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var addressOutlet: UILabel!
    var posts : postStruct?{
        didSet {
            guard let posts = posts else {
                return
            }
          nameOutlet.text = posts.name
           addressOutlet.text = posts.email
           mobileNoOutlet.text = posts.mobileNo
        }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
