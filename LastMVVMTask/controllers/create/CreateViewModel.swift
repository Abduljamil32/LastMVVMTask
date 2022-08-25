//
//  CreateViewModel.swift
//  LastMVVMTask

import Foundation
import Bond

class CreateViewModel{
   
    
    func apiCreatePost(post: Post, handler: @escaping (Bool)-> Void){
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post), handler: { response in
            switch response.result{
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                handler(false)
                print(error)
            }
        })
    }
}

