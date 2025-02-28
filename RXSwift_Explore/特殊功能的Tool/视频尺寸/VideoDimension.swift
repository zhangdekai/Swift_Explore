//
//  VideoDimension.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2024/6/3.
//  Copyright © 2024 mr dk. All rights reserved.
//

import Foundation
import AVFoundation
import CoreMedia


class VideoDimension: NSObject {
    
    
static func printSupportedVideoResolutions() -> [String]{
//        let discoverySession1 = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInUltraWideCamera], mediaType: .video, position: .unspecified)
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera,], mediaType: .video, position: .back)
        
        let captureDevices = discoverySession.devices
        
        print("captureDevices: \(captureDevices.count)")
        
        var result = Set<String>()

        
        for device in captureDevices {
            print("Device: \(device.localizedName)")
            
            let formats = device.formats
            for format in formats {
                let description = format.formatDescription
                let dimensions = CMVideoFormatDescriptionGetDimensions(description)
                
//                print("Width: \(dimensions.width), Height: \(dimensions.height)")
//                
                
                let fb = "\(dimensions.width)x\(dimensions.height)"
                result.insert(fb)
                print("Width x Height: \(fb)")
            }
            
            print("\n")
        }
        print("result == \(result)")
        
        let list = result.map{$0}
        print("list == \(result)")
        
        return list

    }

//    static func getVideoDimensions() async -> [[String: Float]] {
//        
//        let videoUrl = "https://staticai.linke.ai/ssr_cards/ssr_21738_3.mp4"
//        
//        
//        let videoURL = URL(string: videoUrl)!
//
//        do {
//            let playerItem = AVPlayerItem(url: videoURL)
//            let asset = playerItem.asset
//            
//            
//            for videoTrack in asset.tracks {
//                if videoTrack.mediaType == .video {
//                                                    
//                    var result: [[String: Int32]] = []
//
//                    if #available(iOS 15, *) {
//                    
//                        // [CMFormatDescription]
//                        let list = try await videoTrack.load(.formatDescriptions)
//                        
//                        result = list.map{ ["width": $0.dimensions.width, "height": $0.dimensions.height]}
//                        
//                    
//                        print("支持的视频尺寸：\(result)")
//
//                        
//                    } else {
////                        for item in videoTrack.formatDescriptions {
////                            
////                            if let temp = item as? CMFormatDescription {
////                                
//////                            }
//////                                        
//////                            if let formatDescription = item as? AVFormatDescription, formatDescription is CMFormatDescription {
////
////                        
////
////                            result.append(["width": (item as AnyObject).dimensions.width, "height": (item as AnyObject).dimensions.height])
////                                                                
////                            }
////                        
////                        }
//                        print("支持的视频尺寸：\(result)")
//                        
//                    };
//                    
//            
//                }
//            }
//        } catch {
//            print("iOS AVPlayerItem 创建播放器项失败：\(error)")
//        }
//    
//        return []
//    }
    
    
}
