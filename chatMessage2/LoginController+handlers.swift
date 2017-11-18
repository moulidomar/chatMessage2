//
//  LoginController+handlers.swift
//  chatMessage2
//
//  Created by Mo Omar on 8/3/17.
//  Copyright © 2017 Moomar. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func handleRegister() {
        guard let email = emailTF.text, let password = passwordTF.text, let name = nameTF.text else {
            print("Form is not valid")
            return
        }
        
        
        
        //Auth.auth().createUser(withEmail: email, password: password) { (User, error) in
        //}
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (User, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let user = Auth.auth().currentUser
            guard let uid = user?.uid else{
                return
            }
            
            //successfully authenticated user
            let ImageName = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("profile_Images").child("\(ImageName).jpg")
            
            
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1)
            {
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        let values = ["name": name, "email": email, "profileImageUrl":profileImageUrl]
                        //self.registerUserIntoDataBaseWithUID(uid: uid, values: values as [String : AnyObject])
                    }
                })
            }
        })
        
        func registerUserIntoDataBaseWithUID(uid: String, values : [String: AnyObject]) {
            let ref = Database.database().reference(fromURL: "https://chatmessage-e5052.firebaseio.com/")
            let userRef = ref.child("users").child(uid)
            userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
            self.MessagesController?.navigationItem.title = values["name"] as? String
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
    func handleSelectProfileImage() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }

        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        
        dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled picker")
        dismiss(animated: true, completion: nil)
    }
}
