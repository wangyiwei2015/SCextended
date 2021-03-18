//
//  IntentHandler.swift
//  SCext
//
//  Created by Wangyiwei on 2021/3/17.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        switch intent {
        case is SetBrightnessIntent:
            return SetBrightnessHandler()
        case is WriteConfigIntent:
            return WriteConfigHandler()
        case is ReadConfigIntent:
            return ReadConfigHandler()
        default:
            return self
        }
    }
}
