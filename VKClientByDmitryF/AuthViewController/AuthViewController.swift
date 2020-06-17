//
//  AuthViewController.swift
//  VKClientByDmitryF
//
//  Created by Дмитрий Федоринов on 09.06.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: view.center.x - 80,
                                            y: view.frame.height - ((view.frame.height - imageView.frame.height) / 2 + 30),
                                            width: 160, height: 60))
        button.titleLabel?.font = UIFont(name: "Papyrus", size: 30)
        button.setTitle("Login to VK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowRadius = 2
        button.layer.masksToBounds = false
        
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        
        return button
    }()
    
    private lazy var authService: AuthService = SceneDelegate.shared().authService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        authService.wakeUpSession()
    }
    
    @objc private func logIn() {
        authService.wakeUpSession()
    }
}

