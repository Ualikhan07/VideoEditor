//
//  WelcomePageVC+EditorVCDelegate.swift
//  VideoEditor
//
//  Created by Ualikhan Sabden on 30.10.2023.
//

import UIKit
import HXPHPicker

extension WelcomePageVC: EditorViewControllerDelegate {
    
    func editorViewController(_ editorViewController: EditorViewController, didFinish asset: EditorAsset) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if asset.result == nil {
                self.view.hx.showWarning(text: "Can't detect changes", delayHide: 1.5, animated: true)
                return
            }
            
            switch asset.type {
            case .image(let image):
                let localImageAsset = LocalImageAsset.init(image: image)
                let photoAsset = PhotoAsset.init(localImageAsset: localImageAsset)
                photoAsset.editedResult = asset.result
                
                AssetManager.saveSystemAlbum(type: .image(photoAsset.editedResult!.image!), customAlbumName: "VideoEditorApp") {
                    self.view.hx.hide(animated: true)
                    if $0 != nil {
                        self.view.hx.showSuccess(text: "Save in Album", delayHide: 1.5, animated: true)
                    } else {
                        self.view.hx.showWarning(text: "Unable to save", delayHide: 1.5, animated: true)
                    }
                }
                
            case .video(let url):
                let localImageAsset = LocalVideoAsset.init(videoURL: url)
                let videoAsset = PhotoAsset.init(localVideoAsset: localImageAsset)
                videoAsset.editedResult = asset.result
                
                AssetManager.saveSystemAlbum(type: .videoURL(videoAsset.videoEditedResult!.url), customAlbumName: "VideoEditorApp") {
                    self.view.hx.hide(animated: true)
                    if $0 != nil {
                        self.view.hx.showSuccess(text: "Save in Album", delayHide: 1.5, animated: true)
                    } else {
                        self.view.hx.showWarning(text: "Unable to save", delayHide: 1.5, animated: true)
                    }
                }
                
            default: break
                
            }
        }
    }
    
    
    func editorViewController(didCancel editorViewController: EditorViewController) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func editorViewController(
        _ editorViewController: EditorViewController,
        loadMusic completionHandler: @escaping ([VideoEditorMusicInfo]) -> Void) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completionHandler(Tools.musicInfos)
        }
        return true
    }
    
    func editorViewController(
        _ editorViewController: EditorViewController,
        didSearchMusic text: String?,
        completionHandler: @escaping ([VideoEditorMusicInfo], Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completionHandler(Tools.musicInfos, true)
        }
    }
    
    func editorViewController(
        _ editorViewController: EditorViewController,
        loadMoreMusic text: String?,
        completionHandler: @escaping ([VideoEditorMusicInfo], Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completionHandler(Tools.musicInfos, false)
        }
    }
    
    func editorViewController(
        _ editorViewController: EditorViewController,
        loadTitleChartlet response: @escaping EditorTitleChartletResponse
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            response(self.getChartletTitles())
        }
    }
    
   
    func getChartletTitles() -> [EditorChartlet] {
        var titles = PhotoTools.defaultTitleChartlet()
        let localTitleChartlet = EditorChartlet(image: UIImage(named: "hx_sticker_cover"))
        titles.append(localTitleChartlet)
        
        return titles
    }
}
