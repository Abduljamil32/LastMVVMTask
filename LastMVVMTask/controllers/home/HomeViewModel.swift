//
//  HomeViewModel.swift
//  LastMVVMTask


import Foundation
import Bond

class HomeViewModel{
        var items = Observable<[Post]>([])
    
    func apiPostList(){
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { [self] response in
            switch response.result{
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.items.value = posts
            case let .failure(error):
                print(error)
                
            }
        })
    }
    
    func apiPostDelete(post: Post, handler: @escaping (Bool)-> Void){
        
        AFHttp.del(url: AFHttp.API_POST_DELETE + String(post.id!), params: AFHttp.paramsEmpty(), handler: { [self] response in
            switch response.result{
            case .success:
                handler(true)
                print(response.result)
                self.apiPostList()
            case let .failure(error):
                handler(false)
                print(error)
               
            }
        })
    }
}
