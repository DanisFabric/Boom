//
//  UIImage+Boom.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/25.
//  Copyright © 2017年 Danis. All rights reserved.
//

import Foundation

extension UIImage {
    static func image(size: CGSize, color: UIColor, cornerRadius: CGFloat) -> UIImage {
        let frame = CGRect(origin: CGPoint(), size: size)
//        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.addPath(UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius).cgPath)
        context.fillPath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
