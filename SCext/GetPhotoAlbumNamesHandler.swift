//
//  GetPhotoAlbumNamesHandler.swift
//  SCext
//
//  Created by Wangyiwei on 2021/3/18.
//

import Intents
import Photos

class GetPhotoAlbumNamesHandler: NSObject, GetPhotoAlbumNamesIntentHandling {
    func handle(intent: GetPhotoAlbumNamesIntent, completion: @escaping (GetPhotoAlbumNamesIntentResponse) -> Void) {
        guard PhotosHelper.granted() else {
            completion(GetPhotoAlbumNamesIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil))
            return
        }
        let response = GetPhotoAlbumNamesIntentResponse(code: .success, userActivity: nil)
        let names = PhotosHelper.listAlbums()
        response.names = names
        completion(response)
    }
}
