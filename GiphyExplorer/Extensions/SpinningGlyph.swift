//
//  UIViewExtension.swift
//  GiphyExplorer
//
//  Created by Edmund Trujillo on 11/21/17.
//  Copyright © 2017 Edmund Trujillo. All rights reserved.
//

import UIKit

func spinningGlyph(with frame: CGRect?, inView view: UIView?, duration timeDuration:TimeInterval?,
                   withImage image: UIImage?, _ completion:@escaping () -> Void) {
    
    guard let frame = frame, let view = view, let timeDuration = timeDuration,let image = image else { return }
    
    let spinningImageView = UIImageView(frame: frame)
    spinningImageView.image = image
    view.addSubview(spinningImageView)
    
    spinningImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    
    let animator = UIViewPropertyAnimator(duration: timeDuration, curve: .linear, animations: {
        for _ in 0..<10 {
            let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            spinningImageView.transform = spinningImageView.transform.concatenating(rotation)
        }
        let grow = CGAffineTransform(scaleX: 5.0, y: 5.0)
        spinningImageView.transform = spinningImageView.transform.concatenating(grow)
    })
    
    animator.addCompletion { (position) in
        spinningImageView.removeFromSuperview()
        completion()
    }
    
    animator.startAnimation()
}

