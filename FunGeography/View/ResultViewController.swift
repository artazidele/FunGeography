//
//  ResultViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 26/04/2021.
//

import UIKit
import CoreData

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func backToProfile(_ sender: Any) {
        goToProfile()
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var usernameString = String()
    var user = [User]()
    var context: NSManagedObjectContext?
    var result: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        tableView.tableFooterView = UIView()
        self.usernameLabel.text = getPlace()
        self.result = Int(getPlace())
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    func loadData() {
        reiting()
        tableView.reloadData()
    }
    func reiting(){
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
    }
    func goToProfile() {
        navigationController?.popViewController(animated: true)
    }
    func getPlace()->String {
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
            if (user.username == self.usernameString){
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
        return "You are " + placeText + afterInt + medal
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            if (user.username == self.usernameString){
                place = currentUser
                break
            }
            currentUser += 1
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        cell.setUI(with: user[indexPath.row], place: indexPath.row+1, result: place)
        
        return cell
    }
    
}

  
