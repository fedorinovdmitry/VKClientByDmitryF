//
//  GradientView.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 18.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable private var startColor: UIColor? {
        didSet {
            setupGradientColors()
        }
    }
    @IBInspectable private var endColor: UIColor? {
        didSet {
            setupGradientColors()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupGradientLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradientLayer() {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
    }
    
    private func setupGradientColors() {
        guard let startColor = startColor, let endColor = endColor else { return }
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
