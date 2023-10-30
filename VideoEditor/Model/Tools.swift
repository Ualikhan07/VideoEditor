//
//  Tools.swift
//  VideoEditor
//
//  Created by Ualikhan Sabden on 30.10.2023.
//

import UIKit
import HXPHPicker

struct Tools {
    
    static var musicInfos: [VideoEditorMusicInfo] {
        var musics: [VideoEditorMusicInfo] = []
        /*
        let lyricUrl1 = Bundle.main.url(forResource: "NAME", withExtension: nil)!
        let lrc1 = try! String(contentsOfFile: lyricUrl1.path) // swiftlint:disable:this force_try
        let music1 = VideoEditorMusicInfo(audioURL: .network(url: URL(string: "http://.mp3")!), // swiftlint:disable:this line_length
                                               lrc: lrc1)
        musics.append(music1)
         */
        let lyricUrl1 = Bundle.main.url(forResource: "Dead_And_Gone", withExtension: nil)!
        let lrc1 = try! String(contentsOfFile: lyricUrl1.path) // swiftlint:disable:this force_try
        let music1 = VideoEditorMusicInfo(audioURL: .bundle(resource: "Dead_And_Gone", type: "mp3"),
                                               lrc: lrc1)
        musics.append(music1)
        let lyricUrl2 = Bundle.main.url(forResource: "My_Love", withExtension: nil)!
        let lrc2 = try! String(contentsOfFile: lyricUrl2.path) // swiftlint:disable:this force_try
        let music2 = VideoEditorMusicInfo.init(audioURL: .bundle(resource: "My_Love", type: "mp3"),
                                               lrc: lrc2)
        musics.append(music2)
        let lyricUrl3 = Bundle.main.url(forResource: "Tko", withExtension: nil)!
        let lrc3 = try! String(contentsOfFile: lyricUrl3.path) // swiftlint:disable:this force_try
        let music3 = VideoEditorMusicInfo.init(audioURL: .bundle(resource: "Tko", type: "mp3"),
                                               lrc: lrc3)
        musics.append(music3)
        return musics
    }
}

