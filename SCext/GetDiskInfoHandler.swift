//
//  GetDiskInfoHandler.swift
//  SCext
//
//  Created by Wangyiwei on 2021/3/18.
//

import Intents
let b2m: Float = 1024 * 1024

class GetDiskInfoHandler: NSObject, GetDiskInfoIntentHandling {
    func handle(intent: GetDiskInfoIntent, completion: @escaping (GetDiskInfoIntentResponse) -> Void) {
        guard let attr = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else {
            completion(GetDiskInfoIntentResponse(code: .failure, userActivity: nil))
            return
        }
        let total = Float(attr[.systemSize] as! Int)
        let free = Float(attr[.systemFreeSize] as! Int)
        let response = GetDiskInfoIntentResponse(code: .success, userActivity: nil)
        switch intent.type {
        case .used:
            response.result = NSNumber(value: (total - free) / b2m)
            completion(response)
        case .total:
            response.result = NSNumber(value: total / b2m)
            completion(response)
        case .portion:
            response.result = NSNumber(value: free / total)
            completion(response)
        case .unknown:
            completion(GetDiskInfoIntentResponse(code: .failure, userActivity: nil))
        }
    }
    
    func resolveType(for intent: GetDiskInfoIntent, with completion: @escaping (GetDiskInfoTypeResolutionResult) -> Void) {
        let type = intent.type
        if type == .unknown {
            completion(GetDiskInfoTypeResolutionResult.unsupported(forReason: .typeError))
        } else {
            completion(GetDiskInfoTypeResolutionResult.success(with: type))
        }
    }
}
