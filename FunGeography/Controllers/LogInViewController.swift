//
//  LogInViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 19/04/2021.
//

import UIKit
import CoreData

class LogInViewController: UIViewController {
    var user = [User]()
    var context: NSManagedObjectContext?
     @IBOutlet weak var usernameTextField: UITextField!
     @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log In"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    @IBAction func logIn(_ sender: Any) {
        checkUser()
    }
    @IBAction func signUp(_ sender: Any) {
        toSignUp()
    }
    private func warningPopUp(withTitle title: String?, withMessage message: String?) {
        DispatchQueue.main.async {
            let popUp = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            popUp.addAction(okButton)
            self.present(popUp, animated: true)
        }
    }
    private func checkUser() {
        let username = usernameTextField.text!
        let password = passwordTextField.text
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", argumentArray: ["\(username)"])
        do {
            let result = try context?.fetch(request)
            user = result!
            if user.count == 1 {
                let requestPassword = user[0].password
                if password == requestPassword && username != "" {
                    toUserView(username: username, result: Int(user[0].result))
                } else {
                    self.warningPopUp(withTitle: "The password is not correct!", withMessage: "You have to write correct password!")
                    passwordTextField.text = ""
                }
            } else {
                self.warningPopUp(withTitle: "There is an error in username!", withMessage: "You have to write correct username!")
                usernameTextField.text = ""
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    private func toUserView(username: String, result: Int){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "RegionView") as? RegionViewController else { return }
        vc.usernameString = username
        navigationController?.pushViewController(vc, animated: true)
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    private func toSignUp(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "SignUpView") as? SignUpViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
        usernameTextField.text = ""
        passwordTextField.text = ""
        
    }
}

