//
//  SetBrightnessHandler.swift
//  SCext
//
//  Created by Wangyiwei on 2021/3/17.
//

import Intents
import UIKit

class SetBrightnessHandler: NSObject, SetBrightnessIntentHandling {
    
    func handle(intent: SetBrightnessIntent, completion: @escaping (SetBrightnessIntentResponse) -> Void) {
        guard let b = intent.brightness else {
            completion(SetBrightnessIntentResponse(code: .failure, userActivity: nil))
            return
        }
        UIScreen.main.brightness = CGFloat(truncating: b)
        completion(SetBrightnessIntentResponse(code: .success, userActivity: nil))
    }
    
    func resolveBrightness(for intent: SetBrightnessIntent, with completion: @escaping (SetBrightnessBrightnessResolutionResult) -> Void) {
        if let b = intent.brightness {
            let bf = Double(truncating: b)
            if bf < 0.0 {
                completion(SetBrightnessBrightnessResolutionResult.unsupported(forReason: .lessThanMinimumValue))
            } else if bf > 1 {
                completion(SetBrightnessBrightnessResolutionResult.unsupported(forReason: .greaterThanMaximumValue))
            } else {
                completion(SetBrightnessBrightnessResolutionResult.success(with: bf))
            }
        } else {
            completion(SetBrightnessBrightnessResolutionResult.needsValue())
        }
    }
}
