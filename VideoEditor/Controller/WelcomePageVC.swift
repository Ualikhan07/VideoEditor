//
//  WelcomePageVC.swift
//  VideoEditor
//
//  Created by Ualikhan Sabden on 28.10.2023.
//

import UIKit
import SnapKit
import HXPHPicker
import Photos

class WelcomePageVC: UIViewController {
    var photoCollection = [PhotoAsset]()
    var config: EditorConfiguration = .init()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Photo Editing:
        -Adding graphics
        -Add stickers
        -Add text
        -Cropping
        -Mosaic
        -Filters

        Edit video:
        -Adding graphics
        -Add Stickers
        -Adding text
        -Adding an audio track (including text and subtitles)
        -Trim by duration
        -Trim by size
        -Filters
        """
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Project", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 23, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .backgoundColor02
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupSignals()
    }
    
    private func setupLayouts() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.title = "Home"
        
        view.backgroundColor = .backgoundColor01
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
        
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(80)
        }
    }
    
    private func setupSignals() {
        createButton.addTarget(self, action: #selector(handleCreateProjectPressed), for: .touchUpInside)
        
        config.languageType = .english
        config.video.preset = .highQuality
        
        PhotoManager.shared.createLanguageBundle(languageType: config.languageType)
        
    }
    
    @objc private func handleCreateProjectPressed() {
        presentPickerController()
    }
    
    private func presentPickerController() {
        var config = PickerConfiguration.default
        config.maximumSelectedCount = 1
        config.selectMode = .single
        
        let pickerController = PhotoPickerController(picker: config)
        pickerController.pickerDelegate = self
        pickerController.isOriginal = true
        pickerController.autoDismiss = false
        
        self.navigationController?.present(pickerController, animated: true, completion: nil)
    }
    
}

