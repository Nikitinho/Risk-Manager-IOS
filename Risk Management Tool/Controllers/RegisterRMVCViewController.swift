//
//  RegisterRMVCViewController.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 17/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

// TODO: reset password option
// TODO: other user information, like age, country, etc.

import UIKit
import Firebase

class RegisterRMVCViewController: UIViewController {
    
    @IBOutlet var viewT: UIView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var changeImage: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    var imagePicker:UIImagePickerController!
    
    @objc func changeImageAction(_sender:UIButton!)
    {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeImage.addTarget(self, action: #selector(self.changeImageAction(_sender:)), for: UIControl.Event.touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        userImage.createRoundedImageForm()
    }
    
    @IBAction func onRegisterAction(_ sender: Any) {
        
        let username = userName.text ?? ""
        let email = userEmail.text ?? ""
        let passwordConfirmation = confirmPassword.text ?? ""
        let password = userPassword.text ?? ""
        let image = userImage.image ?? nil
        
        let errorMessage = localVerification(username: username, email: email, password: password, confirmPassword: passwordConfirmation, image: image)
        
        if (!errorMessage.isEmpty) {
            LogMessage.showMessage(inVC: self, title: "Info is missing", message: errorMessage)
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            guard error == nil else {
                LogMessage.showMessage(inVC: self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else {
                return
            }
            
            self.uploadUserImage(image!) { url in
                let profileChangeRequest = user.profileChangeRequest()
                profileChangeRequest.displayName = username
                profileChangeRequest.photoURL = url
                
                profileChangeRequest.commitChanges(completion: { (error) in
                    guard error == nil else {
                        LogMessage.showMessage(inVC: self, title: "Something went wrong", message: error!.localizedDescription)
                        return
                    }
                    
                    self.saveUser(userName: username, imageURL: url!) { error in
                        guard error == nil else {
                            LogMessage.showMessage(inVC: self, title: "Error while saving new user", message: error!.localizedDescription)
                            return
                        }
                    }
                })
            }
        })
    }
    
    func localVerification(
        username: String,
        email: String,
        password: String,
        confirmPassword: String,
        image: UIImage?
        ) -> String {
        if (username == "") {
            return "Empty username field"
        } else if (email == "") {
            return "Empty email field"
        } else if (password == "") {
            return "Empty password field"
        } else if (confirmPassword == "") {
            return "Confirm password"
        } else if (password != confirmPassword) {
            return "Passwords do not match"
        } else if (image == nil) {
            return "Picure is not set"
        }
        return ""
    }
    
    func uploadUserImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let storageRef = FIRStorage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.put(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                
                storageRef.downloadURL { url, error in
                    completion(url)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func saveUser(userName:String, imageURL:URL, completion: @escaping ((_ error:Error?)->())) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let databaseRef = FIRDatabase.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": userName,
            "photoURL": imageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error ?? nil)
        }
    }
}

extension RegisterRMVCViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.userImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
