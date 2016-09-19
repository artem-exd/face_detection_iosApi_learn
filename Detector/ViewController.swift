//
//  ViewController.swift
//  Detector
//
//  Created by Gregg Mojica on 8/21/16.
//  Copyright © 2016 Gregg Mojica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var personPic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testedImg = UIImage(named: "face-1")!
        personPic.image = testedImg
        let faceDetector = FaceDetector()
        
        let faceRect = faceDetector.detectFaceRect(img: testedImg)
        let faceRectBorder = UIView()
        faceRectBorder.frame = faceRect
        faceRectBorder.backgroundColor = UIColor.clear
        faceRectBorder.layer.borderColor = UIColor.yellow.cgColor
        faceRectBorder.layer.borderWidth = 4
        faceRectBorder.transform = CGAffineTransform(scaleX: personPic.bounds.width/testedImg.size.width,
                                                     y: -personPic.bounds.height/testedImg.size.height)
        personPic.addSubview(faceRectBorder)
    }
}
