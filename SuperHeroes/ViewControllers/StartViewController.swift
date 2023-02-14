//
//  StartViewController.swift
//  SuperHeroes
//
//  Created by Maxim on 08.01.2023.
//
import AVKit

import UIKit
import AVFoundation
final class StartViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var versionAppLabel: UILabel!
    @IBOutlet var showButton: UIButton!

    // MARK: - Private properties
    private var avPlayer: AVPlayer?

    private var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    // MARK: - LifeCicle View
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        playVideo()
    }

    // MARK: - Private methods
    private func setupView() {
        setupAppVersion()
    }

    private func setupAppVersion() {
        versionAppLabel.text = "Version \(appVersion ?? "1.1.0")"
        versionAppLabel.alpha = 0.4
    }
}

extension StartViewController {
    private func playVideo() {
        if let path = Bundle.main.url(forResource: "Superheroes", withExtension: "mp4") {

            avPlayer = AVPlayer(url: path)
            
            avPlayer?.seek(to: .zero)
            avPlayer?.actionAtItemEnd = .none
            let playerLayer = AVPlayerLayer(player: avPlayer)
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.frame = view.bounds
            view.layer.insertSublayer(playerLayer, at: 0)
            avPlayer?.volume = 0
            avPlayer?.play()
            NotificationCenter.default.addObserver(self, selector: #selector(videoFiniched), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        } else {
            print("no video")
        }
    }
    @objc func videoFiniched() {
        avPlayer?.seek(to: .zero)
    }
}
