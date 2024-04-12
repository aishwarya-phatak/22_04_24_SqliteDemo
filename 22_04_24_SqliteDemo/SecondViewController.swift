//
//  SecondViewController.swift
//  22_04_24_SqliteDemo
//
//  Created by Vishal Jagtap on 12/04/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    var alertController : UIAlertController?
    var okAction : UIAlertAction?
    var cancelAction : UIAlertAction?
    var usernameTextField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showAlerts(_ sender: UIButton) {
        if sender.tag == 1{
            simpleAlert()
        } else if sender.tag == 2{
            alertWithTextField()
        } else {
            actionSheetAlert()
        }
    }
    
    func simpleAlert(){
        alertController = UIAlertController(
            title: "Submit",
            message: "So you really want to submit?",
            preferredStyle: .alert)
        
        okAction = UIAlertAction(title: "Yes", style:.default,handler: {
            action in
            print("Yes button clicked")
        })
        
        cancelAction = UIAlertAction(title: "No", style: .cancel){
            action in
            print("No clicked \(action.description)")
        }
        
        alertController?.addAction(okAction!)
        alertController?.addAction(cancelAction!)
        
        self.present(alertController!, animated: true)
    }
    
    func alertWithTextField(){
        alertController = UIAlertController(
            title: "Save",
            message: "Do you want to save?",
            preferredStyle: .alert)
        
        okAction = UIAlertAction(title: "Sure", style: .default)
        cancelAction = UIAlertAction(title: "No", style: .default)
        
        alertController?.addTextField(){
            textField in
            self.usernameTextField = textField
        }
        
        alertController?.addAction(okAction!)
        alertController?.addAction(cancelAction!)
        self.present(alertController!, animated: true)
    }
    
    func actionSheetAlert(){
        alertController = UIAlertController(
            title: "Submit",
            message: "DO you really want to submit?",
            preferredStyle: .actionSheet)
        
        okAction = UIAlertAction(title: "Yes", style: .default)
        cancelAction = UIAlertAction(title: "No", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .default)
        
        alertController?.addAction(okAction!)
        alertController?.addAction(cancelAction!)
        alertController?.addAction(deleteAction)
        
        self.present(alertController!, animated: true)
    }
}
