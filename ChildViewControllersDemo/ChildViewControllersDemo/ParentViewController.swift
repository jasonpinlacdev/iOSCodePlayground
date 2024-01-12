//
//  ViewController.swift
//  ChildViewControllersDemo
//
//  Created by Jason Pinlac on 1/11/24.
//

import UIKit

class ParentViewController: UIViewController {
    
    let redViewController: UIViewController
    let blueViewController: UIViewController
    
    init(childVC: UIViewController, anotherChildVC: UIViewController) {
        redViewController = childVC
        blueViewController = anotherChildVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.add(redViewController)
        self.add(blueViewController)
        
        
        redViewController.view.translatesAutoresizingMaskIntoConstraints = false
        blueViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            redViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            redViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            redViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            blueViewController.view.topAnchor.constraint(equalTo: redViewController.view.bottomAnchor),
            blueViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blueViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }


}

extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}

