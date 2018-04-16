//
//  NWNesTableViewController.swift
//  News
//
//  Created by zhangjianyun on 2018/4/15.
//  Copyright © 2018年 zhangjianyun. All rights reserved.
//

import UIKit

class NWNesTableViewController: UITableViewController {

    @IBOutlet weak var scrView: UIScrollView!
    let images: [String] = ["cat3","cat1","cat2","cat3","cat1"]
    var refresh = UIRefreshControl()
    var dataArr = ["","",""]
    let width = UIScreen.main.bounds.size.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrView.contentSize = CGSize.init(width: width * 5, height: width)
        for index in 0..<images.count {
            
            let img = UIImageView.init(frame: CGRect.init(x: CGFloat(index) * width, y: 0, width: width, height: width))
            img.contentMode = UIViewContentMode.scaleToFill
            img.image = UIImage.init(named: images[index])
            scrView.addSubview(img)
        }
        
        
        
        //添加刷新
        refresh.addTarget(self, action: #selector(loadData),
                                 for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.view.addSubview(refresh)
        self.loadData()
    }

    @objc func loadData() {
       
        dataArr.append("")
        dataArr.append("")
        refresh.endRefreshing()
        self.reloadInputViews()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //0变3，4变1
        if scrollView == scrView {
           
            let x = scrollView.contentOffset.x / width
            print("x is \(x)")
            
            if x == 0 {
                scrollView.contentOffset.x = 3*width
            }
            if x == 4 {
                scrollView.contentOffset.x = width
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
