import UIKit
import WebKit
import PDFKit
class PdfViewController: UIViewController, WKNavigationDelegate, UIDocumentInteractionControllerDelegate {
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    @IBOutlet weak var pdfCollectionView : UICollectionView!
    var url = [URL]()
    var width = UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        viewModelClass().downloadingPdf { url in
            self.url = url
            self.indicator.stopAnimating()
            self.pdfCollectionView.reloadData()
        }
    }
    
}
extension PdfViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        url.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = url[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PdfCollectionViewCell", for: indexPath) as? PdfCollectionViewCell{
            cell.imageView.widthAnchor.constraint(equalToConstant: ( width/2-10)).isActive = true
            cell.imageView.heightAnchor.constraint(equalToConstant:( width/2-10)).isActive = true
           cell.imageView.image = UIImage(named: "pdf")
         print(url)
            cell.delegate = self
            
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = url[indexPath.row]
        if let cell  = pdfCollectionView.dequeueReusableCell(withReuseIdentifier: "PdfCollectionViewCell", for: indexPath) as? PdfCollectionViewCell{
            indicator.startAnimating()
            if let webObj = storyboard?.instantiateViewController(withIdentifier: "WebKitViewController") as? WebKitViewController{
                webObj.url = url
                self.navigationController?.pushViewController(webObj, animated: true)
            }

        }
        }
    
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
            return CGSize(width: 100, height: 100)
        }
    
}
extension PdfViewController: CellProtocol{
    func passData() {
        
    }
    
    
}
