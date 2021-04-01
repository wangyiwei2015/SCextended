//
//  PhotosHelper.swift
//  SCext
//
//  Created by Wangyiwei on 2021/3/18.
//

import Foundation
import Photos
import AVFoundation

class PhotosHelper: NSObject {
    static func granted() -> Bool {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized, .limited:
            return true
        default:
            return false
        }
    }
    
    static func requestPermission(_ handler: @escaping ((Bool)->Void)) {
        PHPhotoLibrary.requestAuthorization() {state in
            switch state {
            case .authorized, .limited:
                handler(true)
            default:
                handler(false)
            }
        }
    }
    
    static func getAlbumState() -> PHAuthorizationStatus {
        PHPhotoLibrary.authorizationStatus()
    }
    
    static func listAlbums() -> [String] {
        var list = [String]()
        PHCollectionList.fetchTopLevelUserCollections(with: nil).enumerateObjects({collection, index, _ in
            list.append(collection.localizedTitle ?? "")
        })
        return list
    }
    
    static func count(for album: String) -> Int? {
        return 0
    }
    
    static func grantedCam() -> Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    
    static func grantForCam(_ handler: @escaping ((Bool)->Void)) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: handler)
    }
    
    static func getCamState() -> AVAuthorizationStatus {
        AVCaptureDevice.authorizationStatus(for: .video)
    }
}
