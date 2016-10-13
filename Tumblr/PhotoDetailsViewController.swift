//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Jay Liew on 10/12/16.
//  Copyright © 2016 Jay Liew. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let u = url {
            self.photoView.setImageWith(URL(string: u)!)
        }
        
    }

}
