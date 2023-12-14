//
//  SafariView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/12/23.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No need for updates to the view controller
    }
}
