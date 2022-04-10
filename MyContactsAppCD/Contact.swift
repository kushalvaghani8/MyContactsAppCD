//
//  Contact.swift
//  MyContactsAppCD
//
//  Created by Kushal Vaghani on 02/04/2022.
//

import CoreData

@objc(Contact)

class Contact: NSManagedObject {
    
  //  @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var phonenumber: String!
    @NSManaged var deletedDate: Date?
}


