//
//  ViewController.swift
//  Shortcuts-Extended
//
//  Created by Wangyiwei on 2021/1/30.
//

import UIKit

class PermissionViewController: UIViewController {
    
    @IBOutlet weak var btnCam: UIButton!
    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var btnNet: UIButton!
    
    var buttons = [UIButton]()
    let bgColor: [UIColor] = [
        UIColor(hue: 0.58, saturation: 0.3, brightness: 1, alpha: 1),
        .systemGray6,
        UIColor(hue: 0, saturation: 0.2, brightness: 1, alpha: 1)
    ]
    let fgColor: [UIColor] = [
        .systemOrange,
        .systemGreen,
        .systemRed
    ]
    let suffix: [String] = ["(?)", "(√)", "[X]"]
    var originalText = [String]()
    
    enum PermState {
        case unknown
        case granted
        case denied
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [btnCam, btnPhoto, btnNet]
        buttons.forEach({
            originalText.append($0.titleLabel!.text!)
        })
        PhotosHelper.listAlbums()
        //Camera
        switch PhotosHelper.getCamState() {
        case .notDetermined:
            setButton(1, state: .unknown)
        case .authorized:
            setButton(1, state: .granted)
        default:
            setButton(1, state: .denied)
        }
        //Photos
        switch PhotosHelper.getAlbumState() {
        case .notDetermined:
            setButton(2, state: .unknown)
        case .authorized, .limited:
            setButton(2, state: .granted)
        default:
            setButton(2, state: .denied)
        }
        //TODO: Network
    }
    
    @IBAction func onBtnAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("settings")
        case 1:
            if PhotosHelper.getCamState() == .notDetermined {
                PhotosHelper.grantForCam({$0 ? self.setButton(1, state: .granted) : self.setButton(1, state: .denied)})
            } else {
                gotoAuthSettings()
            }
        case 2:
            if PhotosHelper.getAlbumState() == .notDetermined {
                PhotosHelper.requestPermission({$0 ? self.setButton(2, state: .granted) : self.setButton(2, state: .denied)})
            } else {
                gotoAuthSettings()
            }
        case 3:
            print("TODO")
        default:
            fatalError("Invalid tag")
        }
    }
    
    func gotoAuthSettings() {
        //
    }
    
    func setButton(_ tag: Int, state: PermState) {
        DispatchQueue.main.async { [self] in
            let id = tag - 1
            buttons[id].backgroundColor = bgColor[id]
            buttons[id].tintColor = fgColor[id]
            buttons[id].titleLabel?.textColor = fgColor[id]
            buttons[id].setTitle("\(originalText) \(suffix[id])", for: .normal)
        }
    }
}
