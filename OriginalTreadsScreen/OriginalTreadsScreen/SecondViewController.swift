//
//  SecondViewController.swift
//  OriginalTreadsScreen
//
//  Created by Admin on 03/02/22.
//

import UIKit

class SecondViewController: UIViewController {
    var temp3 : Bool = false
    @IBOutlet weak var tableView2: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
extension SecondViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView2.dequeueReusableCell(withIdentifier: "TableViewCell2", for: indexPath) as? TableViewCell2{
            cell.closure1 = {
                if self.temp3 == false {
                    cell.lblS1.numberOfLines = 0
                    self.temp3 = !self.temp3
                    self.tableView2.reloadRows(at: [indexPath], with: .fade)
                }
                else{
                    cell.lblS1.numberOfLines = 1
                    self.temp3 = !self.temp3
                    self.tableView2.reloadRows(at: [indexPath], with: .fade)
                }
                
            }         
           
            cell.lblS1.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
           
            return cell
        }
        return UITableViewCell()
    }
    
    
}
