//
//  CoreDataModel.swift
//  FunGeography
//
//  Created by arta.zidele on 28/04/2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataModel {
    var context: NSManagedObjectContext?
    
    var user = [User]()
    
    func getResult(_ username: String) -> String {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        var resultText = ""
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", argumentArray: ["\(username)"])
        do {
            let result = try context?.fetch(request)
            user = result!
            if user.count == 1 {
                resultText = "\(String(user[0].result))"
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        return resultText
    }
    func deleteProfile(_ username: String) {let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", argumentArray: ["\(username)"])
        do {
            let result = try context?.fetch(request)
            user = result!
            context?.delete(user[0])
        } catch {
            fatalError(error.localizedDescription)
        }
        do {
            try context?.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
