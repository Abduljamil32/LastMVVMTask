//
//  EditViewModel.swift
//  LastMVVMTask

import Foundation

class EditViewModel{

    var editPost: Post?
    
    func apiEditPost(post: Post, handler: @escaping (Bool) -> Void){

        AFHttp.put(url: AFHttp.API_POST_UPDATE + String(post.id!), params: AFHttp.paramsPostUpdate(post: post), handler: { response in
            
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
