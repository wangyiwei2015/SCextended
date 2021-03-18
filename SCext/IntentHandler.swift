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
        case is WriteConfigIntent:
            return WriteConfigHandler()
        case is ReadConfigIntent:
            return ReadConfigHandler()
        case is GetDiskInfoIntent:
            return GetDiskInfoHandler()
        default:
            return self
        }
    }
}
