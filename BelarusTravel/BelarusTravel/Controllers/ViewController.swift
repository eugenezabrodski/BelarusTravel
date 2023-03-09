//
//  ViewController.swift
//  BelarusTravel
//
//  Created by Евгений Забродский on 31.01.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

final class RegistrationViewController: UIViewController {

    //MARK: - Properties
    
    var ref: DatabaseReference!
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!
    
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    //MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        goToRegionWithoutSignUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTF.text = ""
        passwordTF.text = ""
        keyboardHideAndShow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        Auth.auth().removeStateDidChangeListener(authStateDidChangeListenerHandle)
    }
    
    //MARK: - Actions
    
    @IBAction func registrationButton(_ sender: UIButton) {
        guard let email = emailTF.text,
              let password = passwordTF.text,
              email != "",
              password != "" else {
            displayWarningLabel(withText: "Введенные данные некоректны")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                self?.displayWarningLabel(withText: "\(error.localizedDescription)")
            } else if let user = user {
                let userRef = self?.ref.child(user.user.uid)
                userRef?.setValue(["email": user.user.email])
                self?.performSegue(withIdentifier: "showTableView", sender: nil)
                return
            }
        }
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        guard let email = emailTF.text,
              let password = passwordTF.text,
              email != "",
              password != ""
        else {
            displayWarningLabel(withText: "Введенные данные некоректны")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                self?.displayWarningLabel(withText: "\(error.localizedDescription)")
            } else if let _ = user {
                self?.performSegue(withIdentifier: "showTableView", sender: nil)
                return
            } else {
                self?.displayWarningLabel(withText: "Данного аккаунта не существует")
            }
        }
    }
    
    //MARK: - Private functions
    
    private func displayWarningLabel(withText text: String) {
        infoLabel.text = text
        UIView.animate(withDuration: 5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.infoLabel.alpha = 1
        }) { [weak self] _ in
            self?.infoLabel.alpha = 0
        }
    }
    
    private func goToRegionWithoutSignUp() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let _ = user else {
                return
            }
            self?.performSegue(withIdentifier: "showTableView", sender: nil)
        }
    }
    
    private func keyboardHideAndShow() {
            NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIWindow.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIWindow.keyboardWillHideNotification, object: nil)
        }
        
        @objc func kbDidShow(notification: Notification) {
            self.view.frame.origin.y = 0
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= (keyboardSize.height / 2)
            }
        }
        
        @objc func kbDidHide() {
            self.view.frame.origin.y = 0
        }
}

//MARK: - Extensions

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

