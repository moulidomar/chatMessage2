//
//  ChatLodController.swift
//  chatMessage2
//
//  Created by Mo Omar on 8/5/17.
//  Copyright © 2017 Moomar. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate {
    
    var user: User? {
        didSet{
           // navigationItem.title = User!.displayName()
        }
    }
    
    lazy var inputTF: UITextField = {
        let inpuTF = UITextField()
        inpuTF.placeholder = "Message..."
        inpuTF.translatesAutoresizingMaskIntoConstraints = false
        inpuTF.delegate = self
        return inpuTF
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Chat Log"
        collectionView?.backgroundColor = .white
        
        
        setupInputComponents()
        
    }
    
    func setupInputComponents() {
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(containerView)
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        
        
        containerView.addSubview(inputTF)
        inputTF.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTF.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTF.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTF.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        let seperateorLine = UIView()
        seperateorLine.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        seperateorLine.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(seperateorLine)
        
        
        seperateorLine.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperateorLine.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperateorLine.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperateorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    @objc func handleSend() {
        /*
        let ref = Database.database().reference().child("messages")
        _ = ref.childByAutoId()
        let toId = user.providerID
        let values = ["text": inputTF.text!, "name": toId]
        childref.updateChildValues(values) */
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
    
    
    
}
