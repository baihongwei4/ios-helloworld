//
//  ViewController.swift
//  iosAppTestSingle
//
//  Created by Hongwei on 10/7/19.
//  Copyright © 2019 hongwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        myLabel.text = "Hongwei Hello!"
    }


    @IBOutlet weak var androidIcon: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    private var counter = 0
    
    @IBAction func myFunctionName(sender: UIButton) {
        print(sender.tag)
        
//        let name = HongweiUtil
        let hongweiObj = HongweiClass()
        let stringFromClass = hongweiObj.getName() + "My Lucky Number is " + String(hongweiObj.getMyLuckyNumber())
        
        if(sender.tag == 4) {
            counter = counter + 1
            if(counter % 2==0) {
                myLabel.text = "Qantas clicked!" + String(sender.tag)
            } else {
                myLabel.text = stringFromClass
            }
            
            
        } else {
            myLabel.text = "Unknown Tag: " + String(sender.tag)
        }
    }
}

