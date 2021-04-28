//
//  ProfileViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 22/04/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    var usernameString = String()
    let coreData = CoreDataModel()
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func deleteProfileTapped(_ sender: Any) {
        deleteProfile()
    }
    @IBAction func toAllResults(_ sender: Any) {
        seeAllResults()
    }
    @IBAction func toGame(_ sender: Any) {
        toGameView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.helloLabel.text = "Hello, \(usernameString)!"
        self.resultLabel.text = "Result: \(coreData.getResult(usernameString))"
    }
    private func seeAllResults(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "ResultView") as? ResultViewController else { return }
        vc.usernameString = self.usernameString
        navigationController?.pushViewController(vc, animated: true)
    }
    private func toGameView() {
        navigationController?.popViewController(animated: true)
    }
    var user = [User]()
    func deleteProfile() {
        let alert = UIAlertController(title: "Delete!", message: "Are You sure You want to delete Your profile?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.coreData.deleteProfile(self.usernameString)
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
