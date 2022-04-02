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
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(selectedContact != nil) {
            nameTextField.text = selectedContact?.name
            phoneNumberTextField.text = selectedContact?.phonenumber
        }
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedContact == nil) {
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        let newContact = Contact(entity: entity!, insertInto: context)
        //newContact.id = Contacts.count as NSNumber
        newContact.name = nameTextField.text
        newContact.phonenumber = phoneNumberTextField.text
        
        do {
            try context.save()
            Contacts.append(newContact)
            print(Contacts)
            navigationController?.popViewController(animated: true)
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
                    if(contact == selectedContact) {
                        contact.name = nameTextField.text
                        contact.phonenumber = phoneNumberTextField.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch{
                print("Didn't get any contact")
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
                    context.delete(result as! NSManagedObject)
                    try context.save()
                    navigationController?.popViewController(animated: true)
                    
                }
            }
        }
            catch{
                print("Didn't get any contact")
            }
        }
    
    func deleteContact(){
      
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


