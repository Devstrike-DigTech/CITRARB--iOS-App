//
//  LottieView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI
import Lottie
import UIKit


struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    
    var filename = "citrarb_eye_witness_menu"
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()

        
        let animation = LottieAnimation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView()
    }
}
