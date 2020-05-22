//
//  UIImage+Extensions.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

extension UIImage {
    func isBiggerThan(megabytes: Double) -> Bool {
        guard let inputImageData = jpegData(compressionQuality: 1) else {
            return false
        }
        let imgData = NSData(data: inputImageData)
        let imageSize: Int = imgData.count
        let imageMB: Double = Double(imageSize) / 1024.0 / 1024

        return imageMB > megabytes
    }
}
