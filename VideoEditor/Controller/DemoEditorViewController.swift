//
//  DemoEditorViewController.swift
//  VideoEditor
//
//  Created by Ualikhan Sabden on 28.10.2023.
//

import UIKit
import AVKit
import Photos
import MobileCoreServices
import SnapKit

class DemoEditorViewController: UIViewController {
    
    lazy var videoPlayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    lazy var timelineView: TimelineView = {
//        let view = TimelineView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    
    lazy var mediaPickerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Pick More Media", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("|>", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var photoVideoURL: URL?
    var player: AVPlayer?
    
    init(photoVideoURL: URL) {
        super.init(nibName: nil, bundle: nil)
        self.photoVideoURL = photoVideoURL
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        mediaPickerButton.addTarget(self, action: #selector(pickMedia), for: .touchUpInside)
        // Initialize the AVPlayer and AVPlayerLayer for video playback
        
        view.backgroundColor = .backgoundColor01
        view.addSubview(videoPlayerView)
        videoPlayerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(view.snp.centerY)
        }
        
        view.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.centerX.equalTo(videoPlayerView.snp.centerX)
            make.bottom.equalTo(videoPlayerView.snp.bottom).offset(-10)
        }
        
        view.addSubview(timelineView)
        timelineView.snp.makeConstraints { make in
            make.top.equalTo(videoPlayerView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        view.addSubview(mediaPickerButton)
        mediaPickerButton.snp.makeConstraints { make in
            make.top.equalTo(timelineView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        
        
        player = AVPlayer(url: URL(fileURLWithPath: photoVideoURL!.path))
        let playerViewController = AVPlayerViewController()
        playerViewController.showsPlaybackControls = false
        playerViewController.player = player
        
        timelineView.player = player
        
        let videoDuration = player?.currentItem?.asset.duration.seconds
//        timelineView.addMediaItem(MediaItem(type: .video, startTime: CMTime(seconds: 0.0, preferredTimescale: 1), duration: CMTime(seconds: videoDuration ?? 0.0, preferredTimescale: 1), thumbnail: UIImage(named: "logo")!))
        
        
        addChild(playerViewController)
        videoPlayerView.addSubview(playerViewController.view)
        playerViewController.view.frame = videoPlayerView.bounds
        playerViewController.didMove(toParent: self)
        
        // Запустите таймер для обновления временной шкалы
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeline), userInfo: nil, repeats: true)
        
    }
    
    @objc func playPauseButtonTapped() {
        if player?.rate == 0 {
            // Воспроизвести, если видео на паузе
            player?.play()
        } else {
            // Приостановить, если видео воспроизводится
            player?.pause()
        }
    }
    
    @objc func pickMedia(_ sender: UIButton) {
        // Use UIImagePickerController to pick photos and videos
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func updateTimeline() {
        timelineView.updateTimeline()
    }
}

extension DemoEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            // Handle the selected media (photo or video)
            if mediaURL.pathExtension.lowercased() == "jpg" || mediaURL.pathExtension.lowercased() == "jpeg" {
                // This is a photo (JPEG)
                // Implement photo editing logic here
            } else {
                // This is a video
                // Implement video editing logic here
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

/*
//import UIKit

class TimelineView: UIView {
    
    var player: AVPlayer?
    var mediaItems: [MediaItem] = []
    var selectedMediaItem: MediaItem?
    var timeScale: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .gray
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGesture)
    }
    
    func addMediaItem(_ mediaItem: MediaItem) {
        mediaItems.append(mediaItem)
        setNeedsDisplay()
    }
    
    func updateTimeline() {
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        // Рисование временной шкалы
        let timelineHeight: CGFloat = 50.0
        context.setFillColor(UIColor.red.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: bounds.width, height: timelineHeight))
        
        // Рисование медиа-элементов
        for mediaItem in mediaItems {
            let startTimeInPixels = CGFloat(mediaItem.startTime.seconds * timeScale)
            let durationInPixels = CGFloat(mediaItem.duration.seconds * timeScale)
            let mediaItemRect = CGRect(x: startTimeInPixels, y: 0, width: durationInPixels, height: timelineHeight)
            
            if mediaItem == selectedMediaItem {
                context.setFillColor(UIColor.blue.cgColor) // Цвет выделения для выбранного медиа-элемента
            } else {
                context.setFillColor(UIColor.green.cgColor) // Цвет для других медиа-элементов
            }
            
            context.fill(mediaItemRect)
        }
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            let location = gesture.location(in: self)
            var newStartTime = selectedMediaItem?.startTime.seconds ?? 0.0

            for mediaItem in mediaItems {
                let startTimeInPixels = CGFloat(mediaItem.startTime.seconds * timeScale)
                let durationInPixels = CGFloat(mediaItem.duration.seconds * timeScale)
                let mediaItemRect = CGRect(x: startTimeInPixels, y: 0, width: durationInPixels, height: self.bounds.height)

                if mediaItemRect.contains(location) {
                    
                    selectedMediaItem = mediaItem

                    // Calculate the new start time based on the user's interaction
                    let playerDuration = player?.currentItem?.asset.duration.seconds ?? 0.0
                    let relativePosition = location.x - startTimeInPixels
                    newStartTime = mediaItem.startTime.seconds + Double(relativePosition / timeScale)

                    // Ensure the start time is within valid bounds
                    newStartTime = max(0.0, newStartTime)
                    let maxStartTime = playerDuration - selectedMediaItem!.duration.seconds
                    newStartTime = min(newStartTime, maxStartTime)

                    // Update the selected media item's start time
                    selectedMediaItem?.startTime = CMTime(seconds: newStartTime, preferredTimescale: 1)

                    setNeedsDisplay() // Update the timeline view
                    break
                }
            }
        }
    }
}


class MediaItem: Equatable {
    var type: MediaType
    var startTime: CMTime
    var duration: CMTime
    var thumbnail: UIImage
    
    init(type: MediaType, startTime: CMTime, duration: CMTime, thumbnail: UIImage) {
        self.type = type
        self.startTime = startTime
        self.duration = duration
        self.thumbnail = thumbnail
    }
    
    static func == (lhs: MediaItem, rhs: MediaItem) -> Bool {
        
        return lhs.type == rhs.type && lhs.startTime == rhs.startTime && lhs.duration == rhs.duration && lhs.thumbnail == rhs.thumbnail
    }
}

enum MediaType {
    case photo
    case video
}
*/
