//
//  ViewController.swift
//  BelarusTravel
//
//  Created by Евгений Забродский on 31.01.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RegistrationViewController: UIViewController {

    var ref: DatabaseReference!
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func signInButton(_ sender: UIButton) {
    }
    @IBAction func signUpButton(_ sender: UIButton) {
    }
    
}

