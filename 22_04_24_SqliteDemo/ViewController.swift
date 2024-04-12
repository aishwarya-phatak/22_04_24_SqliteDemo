//
//  ViewController.swift
//  22_04_24_SqliteDemo
//
//  Created by Vishal Jagtap on 10/04/24.
//

import UIKit

class ViewController: UIViewController {

//    var p1 : [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DBHelper.shared.insertPersonRecord(name: "Tushar", city: "Pune")
//        DBHelper.shared.insertPersonRecord(name: "Dipali", city: "Pune")
//        DBHelper.shared.insertPersonRecord(name: "Pritam", city: "Pune")
    
        for p in DBHelper.shared.retrivePersonRecords(){
            print("Name \(p.name) -- City \(p.city)")
        }
        
        DBHelper.shared.deletePersonRecords(name: "Tushar")
        
        for p in DBHelper.shared.retrivePersonRecords(){
            print("Name \(p.name) -- City \(p.city)")
        }
    }
}
