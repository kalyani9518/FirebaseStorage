//
//  DemoViewController.swift
//  FirestoreDemo
//
//  Created by Admin on 25/02/22.
//

import UIKit
import Photos
import FirebaseStorage
import FirebaseFirestore

class DemoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var ImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        }
    
    
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            ImageView.contentMode = .scaleAspectFit
            ImageView.image = pickedImage
        }
    }
//

    //MARK: Action
//
//    @IBAction func PressImage(_ sender: UITapGestureRecognizer) {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
//
//    }
    @IBAction func PressImage(_ sender: UITapGestureRecognizer) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            
            imagePicker.allowsEditing = true
        
            present(imagePicker, animated: true)
            {
                self.ImageView.image = self.ImageView.image
            }
        }
    }
}
    
