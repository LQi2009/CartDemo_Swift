//
//  ViewController.swift
//  CartDome-Swift
//
//  Created by Artron_LQQ on 2016/10/24.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40);
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        self.view.addSubview(button)
    }

    func buttonClick() {
        let cart = LZCartViewController()
        
        self.present(cart, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

