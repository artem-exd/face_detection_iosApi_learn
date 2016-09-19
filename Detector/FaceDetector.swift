//
//  FaceDetector.swift
//  Detector
//
//  Created by Artem Sherbachuk (UKRAINE) on 9/19/16.
//  Copyright © 2016 Gregg Mojica. All rights reserved.
//

import UIKit
import CoreImage

class FaceDetector: NSObject {

    
    func detectFaceRect(img: UIImage) -> CGRect {
        guard let ciImage = CIImage(image: img) else { fatalError("can't initialize CIImage with image \(img)") }
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])!
        let features = faceDetector.features(in: ciImage).map{ feature in feature as! CIFaceFeature }
        
        print("Find Face Features count: \(features.count)")
        
        var faceRect = CGRect.zero
        let ciImageSize = ciImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        features.forEach { faceFeature in
            print("faceFeature.hasSmile \(faceFeature.hasSmile)")
            print("faceFeature.bounds \(faceFeature.bounds)")
            
            
            var faceViewBounds = faceFeature.bounds.applying(transform)
            
            let viewSize = UIScreen.main.bounds.size
            let scale = min(viewSize.width / ciImageSize.width,
                            viewSize.height / ciImageSize.height)
            let offsetX = (viewSize.width - ciImageSize.width * scale) / 2
            let offsetY = (viewSize.height - ciImageSize.height * scale) / 2
            
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            faceRect = faceViewBounds
            print("faceFeature.hasLeftEyePosition \(faceFeature.hasLeftEyePosition)")
            print("faceFeature.hasRightEyePosition \(faceFeature.hasRightEyePosition)")
            print("faceFeature.hasMouthPosition \(faceFeature.hasMouthPosition)")
            print("faceFeature.hasTrackingID \(faceFeature.hasTrackingID)")
            print("faceFeature.trackingID \(faceFeature.trackingID)")
            print("faceFeature.hasTrackingFrameCount \(faceFeature.hasTrackingFrameCount)")
            print("faceFeature.trackingFrameCount \(faceFeature.trackingFrameCount)")
            print("faceFeature.hasFaceAngle \(faceFeature.hasFaceAngle)")
            print("faceFeature.faceAngle \(faceFeature.faceAngle)")
            print("faceFeature.leftEyeClosed \(faceFeature.leftEyeClosed)")
            print("faceFeature.rightEyeClosed \(faceFeature.rightEyeClosed)")
            print("faceFeature.rightEyeClosed \(faceFeature.hasSmile)")
        }
        return faceRect
    }
    
}
