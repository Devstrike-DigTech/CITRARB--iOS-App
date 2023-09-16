//
//  UIViewControllerRepresenter.swift
//  CITRARB
//
//  Created by Richard Uzor on 16/09/2023.
//
import AVKit
import SwiftUI

struct UIViewControllerRepresenter: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let viewController = AVPlayerViewController()
        viewController.player = player
        return viewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update any properties or configurations if needed
    }
}
