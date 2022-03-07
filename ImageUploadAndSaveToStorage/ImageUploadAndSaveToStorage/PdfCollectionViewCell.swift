//
//  PdfCollectionViewCell.swift
//  ImageUploadAndSaveToStorage
//
//  Created by Admin on 04/03/22.
//

import UIKit
protocol CellProtocol:AnyObject{
    func passData()
}
class PdfCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var urlBtnAction: UIButton!
    weak var delegate  :CellProtocol?
    var url : URL?{
        didSet{
        
        }
    }
    
    @IBAction func urlBtnAction(_ sender: Any) {
        
        delegate?.passData()
    }
}
