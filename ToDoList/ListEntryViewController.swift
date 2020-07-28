//
//  ListEntryViewController.swift
//  ToDoList
//
//  Created by Bhumi Patel on 6/24/20.
//  Copyright © 2020 Bhumi Patel. All rights reserved.
//

import UIKit

class ListEntryViewController: UIViewController, UITextFieldDelegate {
    
    
    //fields for allowing users to write an entry and save it button
    @IBOutlet var write_field: UITextField!
    
    //pass a reference of a function into this view controller
    var listUpdate: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        write_field.delegate = self

        //adding a save button to save the to-doList entries programmatically as well
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(answerSaved))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerSaved()
        
        return true
    }
    
    
    
    //make it a selector
    @objc func answerSaved() {
        
        guard let listEntry = write_field.text, !listEntry.isEmpty else{
            return
        }
        
        //to save, we will be using "user-default"
        guard let num_of_entries = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        let new_Numcounts = num_of_entries + 1
        UserDefaults().set(new_Numcounts, forKey: "count")
        
        //saving
        UserDefaults().set(listEntry, forKey: "task_\(new_Numcounts)")
        
        //calling the function
        listUpdate?()
        
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
    
    
    
    

}
