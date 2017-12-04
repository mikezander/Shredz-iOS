//
//  CameraVC.swift
//  shredz_workspace
//
//  Created by Michael Alexander on 11/20/17.
//  Copyright © 2017 Michael Alexander. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController {
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var videoOutput: AVCaptureVideoDataOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)

            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }

    @IBAction func cameraBtnPressed(_ sender: Any) {
        //performSegue(withIdentifier: "showVideoSegue", sender: nil)
    }
    /*
     var captureSession = AVCaptureSession()
     var backCamera: AVCaptureDevice?
     var frontCamera: AVCaptureDevice?
     var currentCamera: AVCaptureDevice?
     
     var photoOutput: AVCapturePhotoOutput?
     var videoOutput: AVCaptureVideoDataOutput?
     
     var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
     
     override func viewDidLoad() {
     super.viewDidLoad()
     
     setupCaptureSession()
     setupDevice()
     setupInputOutput()
     setupPreviewLayer()
     startRunningCaptureSession()
     }
     
     func setupCaptureSession() {
     captureSession.sessionPreset = AVCaptureSession.Preset.photo
     }
     
     func setupDevice() {
     let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
     let devices = deviceDiscoverySession.devices
     
     for device in devices {
     if device.position == AVCaptureDevice.Position.back {
     backCamera = device
     } else if device.position == AVCaptureDevice.Position.front {
     frontCamera = device
     }
     }
     currentCamera = backCamera
     }
     
     func setupInputOutput() {
     do {
     let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
     captureSession.addInput(captureDeviceInput)
     
     photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
     } catch {
     print(error)
     }
     }
     
     func setupPreviewLayer() {
     cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
     cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
     cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
     cameraPreviewLayer?.frame = self.view.frame
     self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
     }
     
     func startRunningCaptureSession() {
     captureSession.startRunning()
     }
     
     @IBAction func cameraBtnPressed(_ sender: Any) {
     //performSegue(withIdentifier: "showVideoSegue", sender: nil)
     }
     */
}

