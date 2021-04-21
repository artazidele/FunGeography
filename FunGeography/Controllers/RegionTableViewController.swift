//
//  RegionTableViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 20/04/2021.
//

import UIKit

class RegionTableViewController: UITableViewController {
    var result = Int()
    var won = Bool()
    var usernameString = String()
    var regionList = ["Americas","Oceania","Asia","Europe","Africa","All"]
    @IBOutlet var regionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionTableView.delegate = self
        regionTableView.dataSource = self
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath)
        cell.textLabel?.text = regionList[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "CardGameView") as? ViewController else { return }
        vc.region = regionList[indexPath.row]
        vc.usernameString = self.usernameString
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

