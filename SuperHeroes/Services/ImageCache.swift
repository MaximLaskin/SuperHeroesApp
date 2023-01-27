//
//  ImageCache.swift
//  SuperHeroes
//
//  Created by Maxim on 27.01.2023.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()

    private init() {}
}
