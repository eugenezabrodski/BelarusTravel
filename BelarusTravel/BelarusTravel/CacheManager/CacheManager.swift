//
//  CacheManager.swift
//  BelarusTravel
//
//  Created by Eugene on 08/03/2023.
//

import Foundation
import Alamofire
import AlamofireImage

final class CacheManager {
    private init() {}
    
    static let shared = CacheManager()
    
    let imageCache = AutoPurgingImageCache(memoryCapacity: 100_000_000, preferredMemoryUsageAfterPurge: 60_000_000)
}
