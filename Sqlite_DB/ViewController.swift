//
//  ViewController.swift
//  Sqlite_DB
//
//  Created by Manav Mahajan on 22/09/19.
//  Copyright © 2019 Manav Mahajan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtName :UITextField!
    @IBOutlet weak var txtEmail :UITextField!
    @IBOutlet weak var txtMobile :UITextField!
    
    var allProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showAlert(title: String = "Error", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func actionSaveBtn(_ sender: UIButton) {
        
        if  self.txtName.text == ""{
            showAlert(message: "Please enter name")
        }else if  self.txtEmail.text == ""{
            showAlert(message: "Please enter email")
        }else if  self.txtMobile.text == ""{
            showAlert(message: "Please enter mobile")
        }else{
            DatabaseManagement.shared.addProduct(inputName: txtName.text!, inputEmail: txtEmail.text!, inputMobile: txtMobile.text!)
            self.txtMobile.text = ""
            self.txtEmail.text = ""
            self.txtName.text = ""
            print("Save")
        }
    }
    
    @IBAction func actionShowDataBtn(_ sender: UIButton) {
        allProducts = DatabaseManagement.shared.getProduct()
        if allProducts.count == 0{
            showAlert(message: "Please insert the data  !!!")
        }else{
            let story = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = story.instantiateViewController(withIdentifier: "DataLoadVC") as! DataLoadVC
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

