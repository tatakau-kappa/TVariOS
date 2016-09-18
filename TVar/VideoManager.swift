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
import AWSS3

import Photos

class VideoManager{
    var videoFeed: Observable<[Video]> = Observable([Video]())
    var uploadedVideo: Observable<String> = Observable("")
    var uploadedImage: Observable<String> = Observable("")
    var uploadFlag: Observable<Bool> = Observable(false)
    var finishVideoFlag: Observable<Bool> = Observable(false)
    var lastError: NSError?
    
    let transferManager = AWSS3TransferManager.defaultS3TransferManager()
    
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
                print(self.lastError)
            }
        }
    }
    
    
    func uploadVideo(url: NSURL){
        self.finishVideoFlag <- true
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest.bucket = "tatakau-kappa"
        uploadRequest.key = "raw_videos/\(randomString()).mp4"
        uploadRequest.body = url
        uploadRequest.ACL = .PublicRead
        uploadRequest.contentType = "video/mp4"
        transferManager.upload(uploadRequest).continueWithBlock { (task: AWSTask) -> AnyObject? in
            if task.error == nil && task.exception == nil {
                self.uploadedVideo <- uploadRequest.key!
            } else {
                print("fail")
            }
            return nil
        }
    }
    
    func uploadImage(url: NSURL) {
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest.bucket = "tatakau-kappa"
        uploadRequest.key = "raw_images/\(randomString()).jpeg"
        uploadRequest.body = url
        uploadRequest.ACL = .PublicRead
        uploadRequest.contentType = "image/jpeg"
        transferManager.upload(uploadRequest).continueWithBlock { (task: AWSTask) -> AnyObject? in
            if task.error == nil && task.exception == nil {
                self.uploadedImage <- uploadRequest.key!
                
            } else {
                print("fail")
            }
            return nil
        }
    }
    
    func finishProcess() {
        if uploadedVideo.value != "" && uploadedImage.value != "" {
            let videoData = ["video_uid": uploadedVideo.value as String,
                            "image_uid": uploadedImage.value as String,
                            "program_name": "番組名だよー"]
            let req = APIRouter.FinishVideo(videoData)
            Alamofire.request(req).validate().responseObject{
                (response: Response<User, NSError>) in
                if response.result.error == nil {
                    self.uploadedImage <- ""
                    self.uploadedVideo <- ""
                    self.uploadFlag <- true
                } else{
                    print(response.result.error)
                    self.lastError = response.result.error
                }
            }
        } else {
            print(uploadedVideo.value)
            print(uploadedImage.value)
        }
    }
    
    func randomString() -> String {
        let alphabet = "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let upperBound = UInt32(alphabet.characters.count)
        return String((0..<15).map { _ -> Character in
            return alphabet[alphabet.startIndex.advancedBy(Int(arc4random_uniform(upperBound)))]
            })
    }
    
}