//
//  ImagePicker.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 09/09/21.
//

import UIKit
import Photos

protocol ImagePickerDelegate {
    func didPickImage(_ image: UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate: ImagePickerDelegate?
    
    func showPickerOptions(completion: @escaping (_ option: UIImagePickerController.SourceType) -> Void) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Selecione a fonte da imagem", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { _ in
            completion(.camera)
        }))
        alertController.addAction(UIAlertAction(title: "Galeria de Fotos", style: .default, handler: { _ in
            completion(.photoLibrary)
        }))
        
        return alertController
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        delegate?.didPickImage(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func requestLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { _ in
            
        }
    }
}
