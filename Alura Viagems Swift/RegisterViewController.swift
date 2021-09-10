//
//  RegisterViewController.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 09/09/21.
//

import UIKit

class RegisterViewController: UIViewController, ImagePickerDelegate {
    let imagePicker = ImagePicker()

    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var getPicButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if let name = UserDefaults.standard.object(forKey: "nome") as? String {
            nameTextField.text = name
        }
    }
    
    @IBAction func takePic(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = imagePicker
        
        let alert = imagePicker.showPickerOptions { sourceType in
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text,
              !name.isEmpty
        else { return }
        
        UserDefaults.standard.set(name, forKey: "nome")
    }
    
    func didPickImage(_ image: UIImage) {
        picImageView.image = image
        getPicButton.isHidden = true
    }
    
}
