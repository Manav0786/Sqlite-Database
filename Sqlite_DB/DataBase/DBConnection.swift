//
//  DBConnection.swift
//  ReminderWallpaper
//
//  Created by Mac on 24/07/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import SQLite


class DatabaseManagement {
    static let shared = DatabaseManagement()
    private let db : Connection?
    
    private let reminder = Table("My List")
    private let id = Expression<Int64>("ID")
    private let name = Expression<String?>("name")
    private let email = Expression<String>("email")
    private let mobile = Expression<String>("mobile")
    
         init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print("\(path)")
        do {
            db = try Connection("\(path)/ishop.sqlite")
            createTableProduct()
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    func createTableProduct() {
        do {
            try db!.run(reminder.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(email)
                table.column(mobile)
                     })
            print("create table successfully")
        } catch {
            print("Unable to create table")
        }
    }
    
    func addProduct(inputName: String, inputEmail: String, inputMobile: String) -> Int64? {
        do {
            let insert = reminder.insert(name <- inputName, email <- inputEmail, mobile <- inputMobile)
            let id = try db!.run(insert)
            print("Insert to tblProduct successfully")
            return id
        } catch {
            print("Cannot insert to database")
            
        
            return nil
        }
    }
    
    func updateProduct(productId:Int64, newProduct: Product) -> Bool {
        let tblFilterProduct = reminder.filter(id == productId)
        do {
            let update = tblFilterProduct.update([
                name <- newProduct.name,
                email <- newProduct.email,
                mobile <- newProduct.mobile,
                ])
            if try db!.run(update) > 0 {
                print("Update contact successfully")
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    
     func getProduct() -> [Product]
    {
        var reminder = [Product]()
        do {
            for con in try db!.prepare(self.reminder)
            {
                reminder.append(Product(
                    id: con[id],
                    name: con[name]!,
                    email: con[email],
                    mobile: con[mobile]))
                   
                
                print(" id:\(con[id]),title:\(String(describing: con[name]!)),descrition:\(String(describing: con[email])),date:\(String(describing:con[mobile])) ")
            }
            
        }
        catch
        {
            
        }
        return reminder
    } 
    
    
    
    func deleteProduct(inputId: Int64) -> Bool {
        do {
            let tblFilterProduct = reminder.filter(id == inputId)
            try db!.run(tblFilterProduct.delete())
            print("delete sucessfully")
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
    

    
   /*  let fileUrl = try!
        FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("DBConnection.sqlite") */
    
    
    
    
    
}
