//
//  WriteConfigHandler.swift
//  SCext
//
//  Created by Wangyiwei on 2021/3/17.
//

import Intents

class WriteConfigHandler: NSObject, WriteConfigIntentHandling {
    let defaults = UserDefaults.standard
    
    func handle(intent: WriteConfigIntent, completion: @escaping (WriteConfigIntentResponse) -> Void) {
        guard let key = intent.key else {
            completion(WriteConfigIntentResponse(code: .failure, userActivity: nil))
            return
        }
        guard let val = intent.value else {
            defaults.removeObject(forKey: key)
            completion(WriteConfigIntentResponse(code: .success, userActivity: nil))
            return
        }
        defaults.setValue(val, forKey: key)
        completion(WriteConfigIntentResponse(code: .success, userActivity: nil))
    }
    
    func resolveKey(for intent: WriteConfigIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        //RE check?
        if let key = intent.key {
            completion(INStringResolutionResult.success(with: key))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveValue(for intent: WriteConfigIntent, with completion: @escaping ([INStringResolutionResult]) -> Void) {
        //RE check?
        var results = [INStringResolutionResult]()
        intent.value?.forEach({results.append(INStringResolutionResult.success(with: $0))})
        completion(results)
    }
}
