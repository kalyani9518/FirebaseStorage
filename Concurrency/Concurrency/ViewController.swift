//
//  ViewController.swift
//  Concurrency
//
//  Created by Admin on 27/01/22.
//

import UIKit

class ViewController: UIViewController {
    var urls = [UIImage]()
    let textLabel = UILabel()
    let urlStr = "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg"
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        queueTesting()
//        for i in 1...100{
//            downloadingWithUrlSession()
        //}
        //notifyDisptachGroup()
        // waitDispatchGroup()
    }
    
    func downloadingWithUrlSession(){
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: self.urlStr) else{return}
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    return
                }
                guard let image = UIImage(data: data) else{return}
            
            self.urls.append(image)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }.resume()
    }
   }
    // Thread    //Task
    //serial     + sync   ->ORDER
    //serial     + async  ->ORDER
    //concurrent + sync   ->ORDER
    //concurrent + async  ->UNORDER
    
    //MARK:  Thread And Task
    func queueTesting(){
        let queue1 = DispatchQueue(label: "Serial Thread with synchrous task")
        queue1.async {
            print("Task 1 started")
            for index in 1...5{
                print("\(index) [TASK-1] times \(index) is \(index * 5)")
            }
            print("Task 1 finished")
        }
        queue1.async {
            print("Task 2 started")
         
            print("Task 2 finished")
        }
        queue1.async {
            print("Task 3 started")
         
            print("Task 3 finished")
        }
    }

}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell1", for: indexPath) as? CollectionViewCell1{
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            cell.iamgeView.image = urls[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urls.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
//MARK: DispatchGroup with notify()
extension ViewController{
    func notifyDisptachGroup(){
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "com.company.apple")
        let queue = DispatchQueue(label: "com.company.Bipp")
        group.notify(queue: DispatchQueue.main){
            print("All task are completed")
        }
        queue1.async(group: group) {
            print("queue1 : Task 1 started")
            for index in 1...5{
                print("\(index) [TASK-1] times 5 is \(index * 5)")
            }
            print("queue1 : Task 1 finished")
        }
        queue1.async(group: group) {
            print("queue1 : Task 2 started")
         
            print("queue1 : Task 2 finished")
        }
        queue.async(group: group) {
            print("queue : Task 3 started")
         
            print("queue : Task 3 finished")
        }
      
        
    }
}
//MARK: DispatchGroup with wait()
extension ViewController{
    func waitDispatchGroup(){
        let group = DispatchGroup()
       
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        queue.async(group: group) {
            print("Start job 1")
            Thread.sleep(until: Date().addingTimeInterval(10))
            print("job 1 finished")
        }
        queue.async(group: group) {
            print("Start job 2")
            Thread.sleep(until: Date().addingTimeInterval(10))
            print("job 2 finished")
        }
        queue.async(group: group) {
            print("Start job 3")
            Thread.sleep(until: Date().addingTimeInterval(10))
            print("job 3 finished")
        }
        if group.wait(timeout: .now() + 5) == .timedOut{
            print("Waiting")
        }
        else{
            print("All the task Completed")
        }
        
    }
}
