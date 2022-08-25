//
//  Post.swift
//  LastMVVMTask



import Foundation


class Post: Decodable {
    
    var id: Int?
    var title: String? = ""
    var body: String? = ""
//    var userId: Int?
    
    init(){}
    
    init(title: String, body: String){
        
        self.title = title
        self.body = body
    }
    
    init(id: Int, title: String, body: String){
        self.id = id
        self.title = title
        self.body = body
    }
   
}
