//
//  RegionViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 21/04/2021.
//

import UIKit
import CoreData

class RegionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    var context: NSManagedObjectContext?
    var result = Int()
    var usernameString = String()
    var regionList = ["Americas","Oceania","Asia","Europe","Africa","All"]
    var regionListEmojies = ["Americas 🇨🇦 🇬🇩 🇺🇸 ","Oceania 🇳🇫 🇯🇵 🇫🇯","Asia 🇭🇰 🇮🇷 🇯🇴","Europe 🇸🇮 🇨🇭 🇪🇸","Africa 🇬🇳 🇸🇭 🇸🇨","All"]
    var user = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        tableView.delegate = self
        tableView.dataSource = self
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", argumentArray: ["\(usernameString)"])
        do {
            let result = try context?.fetch(request)
            user = result!
            if user.count == 1 {
                resultLabel.text = "    Result: \(user[0].result)"
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
        tableView.tableFooterView = UIView()
        
        
    }
    
    @IBAction func profile(_ sender: Any) {
        toProfileView()
    }
    @IBAction func logOut(_ sender: Any) {
        toLogInView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oneRegionCell", for: indexPath) as! RegionTableViewCell
        cell.setUI(with: regionListEmojies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "CardGameView") as? ViewController else { return }
        vc.region = regionList[indexPath.row]
        vc.usernameString = self.usernameString
        navigationController?.pushViewController(vc, animated: true)
        //navigationController?.setViewControllers(vc, animated: true)
    }
    private func toLogInView(){
        navigationController?.popToRootViewController(animated: false)
    }
    private func toProfileView(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "ProfileView") as? ProfileViewController else { return }
        vc.usernameString = usernameString
        vc.result = result
        navigationController?.pushViewController(vc, animated: true)
    }
}
