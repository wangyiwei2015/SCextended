//
//  ViewController.swift
//  Shortcuts-Extended
//
//  Created by Wangyiwei on 2021/1/30.
//

import UIKit

class PermissionViewController: UIViewController {
    
//    @IBOutlet weak var btnCam: UIButton!
//    @IBOutlet weak var btnPhoto: UIButton!
//    @IBOutlet weak var btnNet: UIButton!
    @IBOutlet weak var btnCam: UIButton!
    @IBOutlet weak var btnPics: UIButton!
    @IBOutlet weak var btnNet: UIButton!
    @IBOutlet weak var btnMic: UIButton!
    @IBOutlet weak var btnBT: UIButton!
    @IBOutlet weak var labelCam: UILabel!
    @IBOutlet weak var labelPics: UILabel!
    @IBOutlet weak var labelNet: UILabel!
    @IBOutlet weak var labelMic: UILabel!
    @IBOutlet weak var labelBT: UILabel!
    @IBOutlet weak var btnSC: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet var labels: [UILabel]!
    
    let scURL = URL(string: "shortcuts://")!
    let v = Bundle.main.infoDictionary![
        "CFBundleShortVersionString"] as! String? ?? "0"
    let b = Bundle.main.infoDictionary![
        "CFBundleVersion"] as! String? ?? "?"
    
    var buttons = [UIButton]()
    let fgColor: [UIColor] = [
        .systemOrange,
        .systemGreen,
        .systemRed
    ]
    
    var authStateCam: PermState = .unknown {
        willSet {
            switch newValue {
            case .unknown:
                btnCam.isEnabled = true
                btnCam.tintColor = .systemGray
                labelCam.textColor = .systemGray
                labelCam.text = "Cam?"
            case .granted:
                btnCam.isEnabled = false
                btnCam.tintColor = .systemGreen
                labelCam.textColor = .systemGreen
                labelCam.text = "Cam"
            case .denied:
                btnCam.isEnabled = true
                btnCam.tintColor = .systemPink
                labelCam.textColor = .systemPink
                labelCam.text = "!Cam"
            }
        }
    }
    var authStatePics: PermState = .unknown {
        willSet {
            switch newValue {
            case .unknown:
                btnPics.isEnabled = true
                btnPics.tintColor = .systemGray
                labelPics.textColor = .systemGray
                labelPics.text = "Pics?"
            case .granted:
                btnPics.isEnabled = false
                btnPics.tintColor = .systemGreen
                labelPics.textColor = .systemGreen
                labelPics.text = "Pics"
            case .denied:
                btnPics.isEnabled = true
                btnPics.tintColor = .systemPink
                labelPics.textColor = .systemPink
                labelPics.text = "!Pics"
            }
        }
    }
    var authStateNet: PermState = .unknown {
        willSet {
            switch newValue {
            case .unknown:
                btnNet.isEnabled = true
                btnNet.tintColor = .systemGray
                labelNet.textColor = .systemGray
                labelNet.text = "Net?"
            case .granted:
                btnNet.isEnabled = false
                btnNet.tintColor = .systemGreen
                labelNet.textColor = .systemGreen
                labelNet.text = "Net"
            case .denied:
                btnNet.isEnabled = true
                btnNet.tintColor = .systemPink
                labelNet.textColor = .systemPink
                labelNet.text = "!Net"
            }
        }
    }
    var authStateMic: PermState = .unknown {
        willSet {
            switch newValue {
            case .unknown:
                btnMic.isEnabled = true
                btnMic.tintColor = .systemGray
                labelMic.textColor = .systemGray
                labelMic.text = "Mic?"
            case .granted:
                btnMic.isEnabled = false
                btnMic.tintColor = .systemGreen
                labelMic.textColor = .systemGreen
                labelMic.text = "Mic"
            case .denied:
                btnMic.isEnabled = true
                btnMic.tintColor = .systemPink
                labelMic.textColor = .systemPink
                labelMic.text = "!Mic"
            }
        }
    }
    var authStateBT: PermState = .unknown {
        willSet {
            switch newValue {
            case .unknown:
                btnBT.isEnabled = true
                btnBT.tintColor = .systemGray
                labelBT.textColor = .systemGray
                labelBT.text = "BT?"
            case .granted:
                btnBT.isEnabled = false
                btnBT.tintColor = .systemGreen
                labelBT.textColor = .systemGreen
                labelBT.text = "BT"
            case .denied:
                btnBT.isEnabled = true
                btnBT.tintColor = .systemPink
                labelBT.textColor = .systemPink
                labelBT.text = "!BT"
            }
        }
    }
    
    enum PermState {case unknown, granted, denied}

    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [btnCam, btnPics, btnNet, btnMic, btnBT]
        
        versionLabel.text = "v\(v) (\(b))"
        btnSC.layer.cornerRadius = btnSC.frame.height / 4
        
        updatePerms()
    }
    
    func updatePerms() {
        //Camera
        switch PhotosHelper.getCamState() {
        case .notDetermined: authStateCam = .unknown
        case .authorized: authStateCam = .granted
        default: authStateCam = .denied
        }
        //Photos
        switch PhotosHelper.getAlbumState() {
        case .notDetermined: authStatePics = .unknown
        case .authorized, .limited: authStatePics = .granted
        default: authStatePics = .denied
        }
        //TODO: Network
        //TODO: Microphone
        //TODO: Bluetooth
    }
    
    func setGradientColors() {
        let glayer = CAGradientLayer()
        glayer.colors = [
            UIColor(hue: 160/360,
                    saturation: 1,
                    brightness: 1,
                    alpha: 1),
            UIColor(hue: 190/360,
                    saturation: 1,
                    brightness: 1,
                    alpha: 1)
        ]
        glayer.locations = [0.0, 1.0]
        glayer.startPoint = CGPoint(x: 0, y: 0)
        glayer.endPoint = CGPoint(x: 1, y: 1)
        labels.forEach({label in
            glayer.frame = label.bounds
            //label.layer.addSublayer(glayer)
            label.layer.insertSublayer(glayer, at: 0)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !UIApplication.shared.canOpenURL(scURL) {
            btnSC.isEnabled = false
            let alert = UIAlertController(title: "Error", message: "The main functionality of this app requires Shortcuts app to be installed.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        //setGradientColors()
    }
    
    @IBAction func actSC(_ sender: UIButton) {
        if UIApplication.shared.canOpenURL(scURL) {
            UIApplication.shared.open(scURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func onBtnTap(_ sender: UIButton) {
        switch sender.tag {
        case 1: //Cam
            if authStateCam == .denied {
                gotoAuthSettings(sender)
                return
            }
            PhotosHelper.grantForCam({[self] s in
                DispatchQueue.main.async {
                    authStateCam = s ? .granted : .denied
                }
            })
        case 2: //Pics
            if authStatePics == .denied {
                gotoAuthSettings(sender)
                return
            }
            PhotosHelper.requestPermission({[self] s in
                DispatchQueue.main.async {
                    authStatePics = s ? .granted : .denied
                }
            })
        case 3: //Net
            errorAlert(saying: "Not implemented.")
        case 4: //Mic
            errorAlert(saying: "Not implemented.")
        case 5: //BT
            errorAlert(saying: "Not implemented.")
        default: fatalError("Invalid button")
        }
    }
    
    func errorAlert(saying msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func gotoAuthSettings(_ sender: UIButton) {
        let alert = UIAlertController(title: "Modify Permissions", message: "Go to Settings app?", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = sender
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: {_ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
