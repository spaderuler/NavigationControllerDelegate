//
//  ViewController.swift
//  NavigationControllerDelegate
//
//  Created by donggua on 2019/7/23.
//  Copyright © 2019年 wky. All rights reserved.
//

import UIKit

class MianViewController: UIViewController {

    let logoLayer = LogoLayer.logoLayer()
    let transition = RevealAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "main start"
        navigationController?.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        logoLayer.position = CGPoint(x: view.layer.bounds.size.width/2, y: view.layer.bounds.size.height/2)
        logoLayer.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(logoLayer)
    }
    
    @objc func didTap() {
        performSegue(withIdentifier: "detail", sender: nil)
    }
}

extension MianViewController:UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.operation = operation
        return transition
    }
}


