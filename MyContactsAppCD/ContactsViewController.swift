//
//  ContactsViewController.swift
//  MyContactsAppCD
//
//  Created by Kushal Vaghani on 20/04/2022.
//

import UIKit

class ContactsViewController: UIViewController {

    var selectedContact: Contact? = nil
    var index: Int!
    
    var newSelectedContact: Contact? = nil
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        if selectedContact != nil {
            nameLabel.text = selectedContact?.name
            numberLabel.text = selectedContact?.phonenumber
            newSelectedContact = selectedContact
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editContact") {
        print(selectedContact!)
        let dst = segue.destination as! AddContactViewController
        dst.selectedContact = newSelectedContact
        
       // dst.index = index
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
