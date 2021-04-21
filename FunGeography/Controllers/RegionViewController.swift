//
//  RegionViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 21/04/2021.
//

import UIKit

class RegionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    var result = Int()
    var won = Bool()
    var usernameString = String()
    var regionList = ["Americas","Oceania","Asia","Europe","Africa","All"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        resultLabel.text = "\(result)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oneRegionCell", for: indexPath) as! RegionTableViewCell
        cell.textLabel?.text = regionList[indexPath.row]
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
}
