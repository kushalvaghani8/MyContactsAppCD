//
//  AddContactViewController.swift
//  MyContactsAppCD
//
//  Created by Kushal Vaghani on 02/04/2022.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController {

    var selectedContact: Contact? = nil
    
    @IBOutlet weak var deleteOutlet: UIButton!
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteOutlet.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        if(selectedContact != nil) { //if its not nil, filling out the fields
            nameTextField.text = selectedContact?.name
            phoneNumberTextField.text = selectedContact?.phonenumber
            deleteOutlet.isHidden = false
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        if (nameTextField.text!.count <  3) {
            warningLabel.text = "Pleae enter a name"
        } else if (phoneNumberTextField.text!.count < 3) {
            warningLabel.text = "Please enter a phone number"
        }
        else {
            warningLabel.text = ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedContact == nil) { //checking if its nil then saving it as new contact
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context) //creating entity
        let newContact = Contact(entity: entity!, insertInto: context) //inserting into context if entity exists
        //newContact.id = Contacts.count as NSNumber
            newContact.name = nameTextField.text //getting text from fields
        newContact.phonenumber = phoneNumberTextField.text
        
        do {
            try context.save()
            Contacts.append(newContact) //appendig contacts to database
            navigationController?.popToRootViewController(animated: true) //going back to main view
        } catch  {
            print("It failed")
        }
            
        }
        
        else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
            
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let contact = result as! Contact
                    if(contact == selectedContact) { // if there is a contct then its in edit mode
                        contact.name = nameTextField.text
                        contact.phonenumber = phoneNumberTextField.text
                        try context.save()
                        navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
            catch{
                print("Didn't get any contact")
            }
        }
        }
    }
    
    
    @IBAction func deleteContact(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        
        
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                
                let contact = result as! Contact
                if(contact == selectedContact) {
                    
                    contact.deletedDate = Date() //if it is in edit contact (date will be saved)
                    try context.save()
                    navigationController?.popToRootViewController(animated: true) //going back to main view
                    
                }
            }
        }
            catch{
                print("Didn't get any contact")
            }
        }
 
        
        
        
        
//        do {
//            let results:NSArray = try context.fetch(request) as NSArray
//            for result in results {
//                let contact = result as! Contact
//                if(contact == selectedContact) {
//                    contact.name = nameTextField.text
//                    contact.phonenumber = phoneNumberTextField.text
//                    try context.save()
//                    navigationController?.popViewController(animated: true)
//                }
//            }
//        }
//        catch{
//            print("Didn't get any contact")
//        }
//    }
  }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


