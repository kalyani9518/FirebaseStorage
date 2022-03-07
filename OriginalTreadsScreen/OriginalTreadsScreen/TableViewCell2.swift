//
//  TableViewCell2.swift
//  OriginalTreadsScreen
//
//  Created by Admin on 03/02/22.
//

import UIKit
protocol CustmoCellProtocol2:AnyObject{
    func passData(indexPath:IndexPath?,btn:UIButton?)
}
class TableViewCell2: UITableViewCell {
    var temp2 : Bool = true
   // @IBOutlet weak var heightOutlet: NSLayoutConstraint!
    @IBOutlet weak var btnOutlet: UIButton!
    @IBOutlet weak var lblS1: UILabel!
    var closure1 : (()->())?
    weak var delegate2 : CustmoCellProtocol2?
    @IBAction func TapAction(_ sender: Any) {
        self.closure1!()
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
