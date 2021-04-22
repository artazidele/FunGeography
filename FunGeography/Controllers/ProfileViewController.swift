//
//  ProfileViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 22/04/2021.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    
    var result = Int()
    var usernameString = String()
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var helloLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func deleteProfileTapped(_ sender: Any) {
        deleteProfile()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.helloLabel.text = "Hello, \(usernameString)!"
        self.resultLabel.text = "Result: \(result)"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func toGame(_ sender: Any) {
        toGameView()
    }
    private func toGameView() {
        //navigationController?.popToRootViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    var user = [User]()
    func deleteProfile() {
        let alert = UIAlertController(title: "Delete!", message: "Are You sure You want to delete Your profile?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "username == %@", argumentArray: ["\(self.usernameString)"])
            do {
                print("Delete")
                let result = try self.context?.fetch(request)
                self.user = result!
                self.context?.delete(self.user[0])
            } catch {
                fatalError(error.localizedDescription)
            }
            do {
                try self.context?.save()
            } catch {
                fatalError(error.localizedDescription)
            }
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        present(alert, animated: true)
    }
}
