//
//  TableViewCell1.swift
//  OriginalTreadsScreen
//
//  Created by Admin on 02/02/22.
//

import UIKit

class TableViewCell1: UITableViewCell {
    var indexPath : IndexPath?
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    var temp :Bool = true
    @IBOutlet weak var lbl3: UILabel!

    @IBOutlet weak var lbl4: UILabel!
    
    @IBOutlet weak var lbl5: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var btnOutlet: UIButton!
   
    var closur : (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func readMoreAction(_ sender: Any) {
        self.closur!()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
