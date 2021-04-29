//
//  ResultViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 26/04/2021.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let coreData = CoreDataModel()
    @IBAction func backToProfile(_ sender: Any) {
        goToProfile()
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var usernameString = String()
    var user = [User]()
    var result: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.usernameLabel.text = coreData.getPlace(usernameString)
        self.result = Int(coreData.getPlace(usernameString))
        tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    func loadData() {
        user=coreData.reiting()
        tableView.reloadData()
    }
    func goToProfile() {
        navigationController?.popViewController(animated: true)
    } 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        user = coreData.reiting()
        let bestResult = user[indexPath.row].bestresult
        let alert = UIAlertController(title: "Best result: ", message: "\(bestResult)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        user = coreData.reiting()
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

  
