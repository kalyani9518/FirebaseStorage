//
//  WebKitViewController.swift
//  ImageUploadAndSaveToStorage
//
//  Created by Admin on 04/03/22.
//

import UIKit
import SafariServices
import WebKit
class WebKitViewController: UIViewController {
    @IBOutlet weak var webnit : WKWebView!
    var url : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(url!)
        webnit.load(URLRequest(url: url!))
        
    }
    
    @IBAction func bacBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//        let pdfView = PDFView(frame: self.view.bounds)
//
//                self.view.addSubview(pdfView)
//
//                // Fit content in PDFView.
//                pdfView.autoScales = true
//
//                // Load Sample.pdf file.
//                                    pdfView.document = PDFDocument(url: url)
//        pdfView.canGoBack

}
