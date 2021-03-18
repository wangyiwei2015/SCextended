//
//  ReadConfigHandler.swift
//  SCext
//
//  Created by Wangyiwei on 2021/3/17.
//

import Intents

class ReadConfigHandler: NSObject, ReadConfigIntentHandling {
    func handle(intent: ReadConfigIntent, completion: @escaping (ReadConfigIntentResponse) -> Void) {
        guard let key = intent.key else {
            completion(ReadConfigIntentResponse(code: .failure, userActivity: nil))
            return
        }
        let value = UserDefaults.standard.array(forKey: key)
        let response = ReadConfigIntentResponse(code: .success, userActivity: nil)
        guard let array = value else {
            response.value = nil
            completion(response)
            return
        }
        response.value = (array as! [String])
        completion(response)
    }
    
    func resolveKey(for intent: ReadConfigIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        //RE check?
        guard let key = intent.key else {
            completion(INStringResolutionResult.needsValue())
            return
        }
        completion(INStringResolutionResult.success(with: key))
    }
}
