//
//  ViewController.swift
//  CartDemo_Swift
//
//  Created by Artron_LQQ on 16/6/27.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(100, 100, 100, 40);
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
    }

    func buttonClick() {
        let cart = LZCartViewController()
        
        self.presentViewController(cart, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

