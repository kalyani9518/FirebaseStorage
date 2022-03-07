//
//  FirebaseTableViewCell.swift
//  ReviseGADemo
//
//  Created by Admin on 22/02/22.
//

import UIKit

class FirebaseTableViewCell: UITableViewCell {

    @IBOutlet weak var mobileNoOutlet: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var addressOutlet: UILabel!
    
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactPhoneNumLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var lastSeenLabel: UILabel!
    @IBOutlet weak var profileDescriptionLabel: UILabel!
    var posts : postStruct?{
        didSet {
            guard let posts = posts else {
                return
            }
          nameOutlet.text = posts.name
           addressOutlet.text = posts.contactEmail
           mobileNoOutlet.text = posts.contactNo
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
