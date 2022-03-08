//
//  ViewController.swift
//  ImageUploadAndSaveToStorage
//
//  Created by Admin on 28/02/22.
//

import UIKit
import FirebaseStorage
import CoreServices
class ViewController: UIViewController {
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    @IBOutlet weak var collectioView : UICollectionView!
    var url: [URL] = [URL](){
        didSet {
            self.collectioView.reloadData()
        }
    }
    var imageArr: [Data] = [Data]() {
        didSet {
            self.collectioView.reloadData()
        }
    }
    
    let storageRef = Storage.storage().reference()
    var im : UIImage?
    var width = UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        ViewModelClass().downLoadingImage { imageArr, url in
             self.imageArr = imageArr
            self.url = url
            self.indicator.stopAnimating()
        }
        test()
            
    }
    @IBAction func NextVC(_ sender: Any) {
        if let googleSignInViewController = storyboard?.instantiateViewController(withIdentifier: "GoogleSignInViewController") as? GoogleSignInViewController{
            self.navigationController?.pushViewController(googleSignInViewController, animated: true)
        }
    }
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    @IBAction func segControlAction(_ sender: Any) {
        switch segmentControlOutlet.selectedSegmentIndex
                {
                case 0:
            self.collectioView.reloadData()
            self.collectioView.isHidden = false
                case 1:
             self.collectioView.isHidden = false
            collectioView.reloadData()
                default:
                    break;
                }
    }
    func test() {
        let image = UIAction(title: "Upload Image", image: UIImage(systemName: "chevron.right")) {_ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
    }
        let file = UIAction(title: "Uplaod File", image: UIImage(systemName: "chevron.right")) {_ in
            let picker = UIDocumentPickerViewController.init(documentTypes: [".pdf", ".xls", ".doc", ".docx",".png",".jpg"], in: .open)
            picker.delegate = self
            picker.modalPresentationStyle = .fullScreen
            self.present(picker, animated: true, completion: nil)
            }
            let upload = UIMenu(title: "", options: .displayInline,children: [image, file])
        menuBtn.menu = upload
        menuBtn.showsMenuAsPrimaryAction = true
    }
}
extension ViewController:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        let last = myURL.pathExtension
        self.url.append(myURL)
        if last == "pdf"  {
            ViewModelClass().uploadFile(myURL: myURL, extensionStr: ".pdf")
        }
        else if last == "doc"{
            ViewModelClass().uploadFile(myURL: myURL, extensionStr: ".doc")
            }
        else if last == "docx"{
            ViewModelClass().uploadFile(myURL: myURL, extensionStr: ".docx")
            
        } else if last == "xls"{
            ViewModelClass().uploadFile(myURL: myURL, extensionStr: ".xls")
                }
        else if last == "jpg"{
            ViewModelClass().uploadFile(myURL: myURL, extensionStr: ".xls")
                }
    
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        if controller.documentPickerMode == UIDocumentPickerMode.import {
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController){
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
}
}
extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else{
            return
        }
        self.im = image
        guard let  data = image.pngData() else{
            return
        }
       
        indicator.startAnimating()
        storageRef.child("Document").child(UUID().uuidString + ".jpg").putData(data, metadata: nil) { [weak self] storageData, error in
            self?.imageArr.append(data)
            self?.indicator.stopAnimating()
        }
        print("////////",info.values)
        dismiss(animated: true, completion: nil)
    }
}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentControlOutlet.selectedSegmentIndex == 0{
       return imageArr.count
        }
        else{
         return   url.count
            
        }
     
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = url[indexPath.row]
        if collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) is CollectionViewCell{
            if segmentControlOutlet.selectedSegmentIndex == 1{
            indicator.startAnimating()
            if let webObj = storyboard?.instantiateViewController(withIdentifier: "WebKitViewController") as? WebKitViewController{
                print(url)
                webObj.url = url
                self.navigationController?.pushViewController(webObj, animated: true)
            }
            }
        }
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell{
            cell.imageView.widthAnchor.constraint(equalToConstant: ( width/2-10)).isActive = true
            cell.imageView.heightAnchor.constraint(equalToConstant:( width/2-10)).isActive = true
            if segmentControlOutlet.selectedSegmentIndex == 0{
                let imgData = imageArr[indexPath.row]
            cell.imageView.image = UIImage(data: imgData)
            }
            else{
                indicator.stopAnimating()
                let url = url[indexPath.row]
                switch url.pathExtension{
                case "pdf" :
                cell.imageView.image = UIImage(named: "pdf")
                case "doc" :
                cell.imageView.image = UIImage(named: "docs")
                case "docx" :
                cell.imageView.image = UIImage(named: "docx")
                case "xls" :
                cell.imageView.image = UIImage(named: "xls")
                default :
                    break
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
}
