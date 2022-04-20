//
//  ContactsTableViewController.swift
//  MyContactsAppCD
//
//  Created by Kushal Vaghani on 02/04/2022.
//

import UIKit
import CoreData
var Contacts = [Contact]()
var addContact = AddContactViewController()

class ContactsTableViewController: UITableViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    var firstload = true
    
    
    func nonDeletedContacts() -> [Contact]{ //checking if the contact is not deleted
        var nonDeleteContactList = [Contact]()
        for contact in Contacts {
            if (contact.deletedDate == nil) { //we've saved date when contact is deleted, so checking if the date is nil, means the contact is not deleted
                nonDeleteContactList.append(contact) //if its not, appending it to non deleted list
            }
        }
        return nonDeleteContactList
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if (firstload) { // if the app is running for first time getting all the contact from entity
            firstload = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let contact = result as! Contact
                    Contacts.append(contact)
                }
            }
            catch{
                print("Didn't get any contact")
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        tableView.reloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        tableView.reloadData()
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nonDeletedContacts().count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)

        
        // Configure the cell...
        cell.textLabel?.text = nonDeletedContacts()[indexPath.row].name //if contact is not deleted

        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "editContact", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "ViewContact") { //checking if user just wants to view contact, else its in add new contact
       
        let dst = segue.destination as! ContactsViewController
        let indexPath = tableView.indexPathForSelectedRow!
        dst.selectedContact = nonDeletedContacts()[indexPath.row]
        dst.index = tableView.indexPathForSelectedRow?.row
        }
//
//        if(segue.identifier == "viewContact") {
//            let indexPath = tableView.indexPathForSelectedRow!
//            let contactDetail = segue.destination as? ContactsViewController
//
//            let selectedContact: Contact!
//            selectedContact = nonDeletedContacts()[indexPath.row]
//            contactDetail!.selectedContact = selectedContact
//
//            print("****************")
//            print(selectedContact!)
//            print("****************")
    
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.5) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
