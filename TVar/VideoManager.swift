//
//  VideoManager.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import Observable
import Photos

class VideoManager{
    var videoFeed: Observable<[Video]> = Observable([Video]())
    var inputVideos = [PHAsset]()
    var lastError: NSError?
    
    func loadMockFeed(page: Int){
        dispatch_async(dispatch_get_main_queue(),{
            let video = Video()
            var tempFeed = [Video]()
            for _ in 0..<5{
                tempFeed.append(video)
            }
            self.videoFeed <- tempFeed
        })
    }
    
    func loadFeed(page: Int){
        let req  = APIRouter.GetHomeFeed
        
        Alamofire.request(req).validate().responseArray{
            (response: Response<[Video], NSError>) in
            if response.result.error == nil {
                self.videoFeed <- response.result.value!
            } else{
                self.lastError = response.result.error
            }
        }
    }
//
//    func uploadVideo(data: NSData, id: Int){
//        //        let params = ["id": id.description]
//        //        let req = VideoRouter.Upload(id)
//        let array = [id]
//        print("here")
//        Alamofire.upload(
//            .POST,
//            "http://104.236.157.63:5000/videos",
//            multipartFormData: { multipartFormData in
//                multipartFormData.appendBodyPart(data: data, name: "video")
//                multipartFormData.appendBodyPart(data: NSData(bytes: array, length: array.count * sizeof(Int)), name: "id")
//            },
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .Success(let upload, _, _):
//                    upload.responseJSON {
//                        (response: Response<AnyObject, NSError>) in
//                        print(response)
//                        
//                    }
//                    
//                case .Failure(let encodingError):
//                    print(encodingError)
//                }
//            }
//        )
//        
//        
//    }
//    
//    func getUploadID(movies: [PHAsset]){
//        inputVideos = movies
//        let params = getUploadParams(movies)
//        let req = APIRouter.GetUploadID(params)
//        Alamofire.request(req).validate().responseJSON{
//            (response: Response<AnyObject, NSError>) in
//            if response.result.error == nil {
//                // TODO: Connect selectUpload
//                let value = response.result.value!
//                let names = self.getUploadNames(value)
//                let id = value["id"] as! Int
//                self.selectUploadVideos(names, id: id)
//            } else{
//                self.lastError = response.result.error
//            }
//        }
//    }
//    
//    func getUploadParams(movies: [PHAsset]) -> [String: AnyObject]{
//        var movieDatas = [[String: String]]()
//        let date_formatter: NSDateFormatter = NSDateFormatter()
//        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
//        date_formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        for movie in movies{
//            let name = movie.valueForKeyPath("filename") as! String
//            let createDate = date_formatter.stringFromDate(movie.valueForKeyPath("creationDate") as! NSDate)
//            movieDatas.append(["filename": name, "date": createDate])
//        }
//        let music = ManagerLocator.sharedInstance.musicManager.checkMusic.value!
//        let params = [
//            "inputVideos" : movieDatas,
//            "music": [
//                "id": music.id,
//                "streamUrl": music.streamUrl,
//                "downloadUrl": music.downloadUrl
//            ]
//        ]
//        return params as! [String : AnyObject]
//    }
//    
//    func selectUploadVideos(names: [String], id: Int){
//        for video in inputVideos {
//            let name = video.valueForKeyPath("filename") as! String
//            if names.contains(name) {
//                PHCachingImageManager().requestAVAssetForVideo(video, options: nil, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [NSObject : AnyObject]?) in
//                    dispatch_async(dispatch_get_main_queue(), {
//                        let asset = asset as? AVURLAsset
//                        let data = NSData(contentsOfURL: asset!.URL)
//                        self.uploadVideo(data!, id: id)
//                    })
//                })
//            }
//        }
//    }
//    
//    func getUploadNames(data: AnyObject) -> [String]{
//        var names = [String]()
//        let inputVideos = data["inputVideos"] as! [AnyObject]
//        for inputVideo in inputVideos {
//            if inputVideo["uploaded"] as! Int == 0 {
//                names.append(inputVideo["filename"] as! String)
//            }
//        }
//        return names
//    }
    
}