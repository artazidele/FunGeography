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
    
    func reiting() -> [User] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let sortDescriptor = NSSortDescriptor(key: "result", ascending: false,
                                                  selector: #selector(NSString.localizedStandardCompare))
            request.sortDescriptors = [sortDescriptor]
            let result = try context?.fetch(request)
            user = result!
        } catch {
            fatalError(error.localizedDescription)
        }
        return user
    }
    func getPlace(_ username: String) -> String {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let sortDescriptor = NSSortDescriptor(key: "result", ascending: false,
                                                  selector: #selector(NSString.localizedStandardCompare))
            request.sortDescriptors = [sortDescriptor]
            let result = try context?.fetch(request)
            user = result!
        } catch {
            fatalError(error.localizedDescription)
        }
        var place = 0
        var currentUser = 1
        for user in user {
            if (user.username == username){
                place = currentUser
                break
            }
            currentUser += 1
        }
        let placeText = String(place)
        var afterInt = ""
        if (placeText.last=="1") {
            afterInt = "st"
        } else if (placeText.last=="2") {
            afterInt = "nd"
        } else if (placeText.last=="3") {
            afterInt = "rd"
        } else {
            afterInt = "th"
        }
        var medal = ""
        if (place==1) {
            medal = "🥇"
        } else if (place==2) {
            medal = "🥈"
        } else if (place==3) {
            medal = "🥉"
        }
        return "    You are " + placeText + afterInt + medal
        
    }
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
