//
//  DataLoadVC.swift
//  Sqlite_DB
//
//  Created by Manav Mahajan on 22/09/19.
//  Copyright © 2019 Manav Mahajan. All rights reserved.
//

import UIKit

class DataLoadVC: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tbl:UITableView!

    var allProducts = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()

        allProducts = DatabaseManagement.shared.getProduct()
        self.tbl.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = allProducts[indexPath.row].name
        return cell!
    }
    
    @IBAction func actionBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
