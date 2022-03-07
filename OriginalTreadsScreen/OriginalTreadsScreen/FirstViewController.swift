//
//  FirstViewController.swift
//  OriginalTreadsScreen
//
//  Created by Admin on 02/02/22.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goNxt(_ sender: Any) {
        if let nextVc  = storyboard?.instantiateViewController(withIdentifier: "NextViewController") as? NextViewController{
            self.navigationController?.pushViewController(nextVc, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
