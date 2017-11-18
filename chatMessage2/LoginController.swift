//
//  LoginController.swift
//  chatMessage2
//
//  Created by Mo Omar on 7/30/17.
//  Copyright © 2017 Moomar. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var MessagesController: MessagesController?
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    lazy var LoginRegisterSegmentedControl: UISegmentedControl = {
        let sc  = UISegmentedControl(items: ["Login", "Register"])
        sc.tintColor = .white
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange, for: .valueChanged))
        return sc
    }()
    
    func handleLoginRegisterChange(){
        let title = LoginRegisterSegmentedControl.titleForSegment(at: LoginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        // change for height of containerView
        inputsContainerViewHeightAnchor?.constant = LoginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // change height of nameTF
        nameTFHeightAnchor?.isActive = false
        nameTFHeightAnchor = nameTF.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: LoginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTFHeightAnchor?.isActive = true
        
        // emailTF change
        emailTFHeightAnchor?.isActive = false
        emailTFHeightAnchor = emailTF.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: LoginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTFHeightAnchor?.isActive = true
        
        // passwordTF change
        passwordTFHeightAnchor?.isActive = false
        passwordTFHeightAnchor = passwordTF.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: LoginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTFHeightAnchor?.isActive = true
        
        
    }
    
    
    
    
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLoginRegister() {
        if LoginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else{
            handleRegister()
        }
        
    }
    
    
    @objc func handleLogin() {
        guard let email = emailTF.text, let password = passwordTF.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            self.MessagesController?.fetchUserAndSetUpNavBarTitle()
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    let nameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email address"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MoliciousLogo")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.addGestureRecognizer(UIGestureRecognizer(target: self, action:  #selector(handleSelectProfileImage)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(LoginRegisterSegmentedControl)
        
        setupInputViews()
        setupLoginRegister()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
    }
    
    func setupLoginRegisterSegmentedControl(){
        LoginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        LoginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        LoginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    
    func setupProfileImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: LoginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTFHeightAnchor: NSLayoutConstraint?
    var emailTFHeightAnchor: NSLayoutConstraint?
    var passwordTFHeightAnchor: NSLayoutConstraint?
    
    
    
    func setupInputViews() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTF)
        inputsContainerView.addSubview(nameSeperator)
        inputsContainerView.addSubview(emailTF)
        inputsContainerView.addSubview(emailSeperator)
        inputsContainerView.addSubview(passwordTF)
        
        nameTF.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTF.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTF.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTFHeightAnchor = nameTF.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTFHeightAnchor?.isActive = true
        
        
        nameSeperator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeperator.topAnchor.constraint(equalTo: nameTF.bottomAnchor).isActive = true
        nameSeperator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTF.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor).isActive = true
        emailTF.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTFHeightAnchor = emailTF.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTFHeightAnchor?.isActive = true
        
        
        emailSeperator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeperator.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        emailSeperator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTF.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTF.topAnchor.constraint(equalTo: emailSeperator.bottomAnchor).isActive = true
        passwordTF.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTFHeightAnchor = passwordTF.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTFHeightAnchor?.isActive = true
        
        
    }
    
    func setupLoginRegister(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
