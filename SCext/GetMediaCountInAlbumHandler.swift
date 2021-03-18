//
//  GetMediaCountInAlbumHandler.swift
//  SCext
//
//  Created by Wangyiwei on 2021/3/18.
//

import Intents
import Photos

class GetMediaCountInAlbumHandler: NSObject, GetMediaCountInAlbumIntentHandling {
    func handle(intent: GetMediaCountInAlbumIntent, completion: @escaping (GetMediaCountInAlbumIntentResponse) -> Void) {
        guard let name = intent.name else {
            completion(GetMediaCountInAlbumIntentResponse(code: .failure, userActivity: nil))
            return
        }
        guard PhotosHelper.granted() else {
            completion(GetMediaCountInAlbumIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil))
            return
        }
        let cnt = PhotosHelper.count(for: name)!
        let response = GetMediaCountInAlbumIntentResponse(code: .success, userActivity: nil)
        response.mediaCount = NSNumber(value: cnt)
        completion(response)
    }
    
    func resolveName(for intent: GetMediaCountInAlbumIntent, with completion: @escaping (GetMediaCountInAlbumNameResolutionResult) -> Void) {
        guard let name = intent.name else {
            completion(GetMediaCountInAlbumNameResolutionResult.needsValue())
            return
        }
        guard PhotosHelper.count(for: name) != nil else {
            completion(GetMediaCountInAlbumNameResolutionResult.unsupported(forReason: .noSuchName))
            return
        }
        completion(GetMediaCountInAlbumNameResolutionResult.success(with: name))
    }
}
