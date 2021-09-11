//
//  RegisterViewController.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 09/09/21.
//

import UIKit
import PhotosUI
import SwiftyJSON
import Alamofire

class RegisterViewController: UIViewController, ImagePickerDelegate {
    let imagePicker = ImagePicker()
    var users: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var getPicButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if let name = UserDefaults.standard.object(forKey: "nome") as? String {
            nameTextField.text = name
        }
        //tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        ReqressAPI.shared.getUsers { users in
            self.users = users
        }
    }
    
    @IBAction func takePic(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = imagePicker
        let alert = imagePicker.showPickerOptions { sourceType in
            imagePickerController.sourceType = sourceType
            DispatchQueue.main.async {
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text,
              !name.isEmpty
        else { return }
        
        UserDefaults.standard.set(name, forKey: "nome")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        ReqressAPI.shared.createUser(name: name, job: "Developer")
    }
    
    func didPickImage(_ image: UIImage) {
        picImageView.image = image
        getPicButton.isHidden = true
    }
    
}

extension RegisterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as? UserTableViewCell else { return UITableViewCell()
        }
        cell.user = users[indexPath.row]
        return cell
    }
}

//        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            if let error = error {
//                print(error)
//                return
//            }
//
//            guard let data = data,
//                  let json = try? JSON(data: data)
//            else { return }
//
//            self.users = json["data"].arrayValue.map { User(json: $0) }
//            print(self.users)
//
//            //print(json)
//        }
//        task.resume()
