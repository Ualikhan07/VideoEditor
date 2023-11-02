//
//  WelcomePageVC+PhotoPickerControllerDelegate.swift
//  VideoEditor
//
//  Created by Ualikhan Sabden on 30.10.2023.
//

import UIKit
import HXPHPicker

extension WelcomePageVC: PhotoPickerControllerDelegate {
    
    func pickerController(_ pickerController: PhotoPickerController, didFinishSelection result: PickerResult) {
        pickerController.dismiss(true) {
            
            result.photoAssets.getURLs { result, photoAsset, index  in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    switch result {
                    case .success(let response):
                        
                        switch response.mediaType {
                        case .photo:
                            let vc = EditorViewController(.init(type: .image(photoAsset.originalImage!)), config: self.config)
                            vc.delegate = self
                            self.navigationController?.pushViewController(vc, animated: true)
                        case .video:
                            let vc = EditorViewController(.init(type: .video(response.url)), config: self.config)
                            vc.delegate = self
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            } completionHandler: { _ in }
        }
    }
    
    
    func pickerController(didCancel pickerController: PhotoPickerController) {
        pickerController.dismiss(true)
    }
}
