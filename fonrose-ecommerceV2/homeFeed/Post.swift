//
//  Post.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import Foundation

let downloadedPosts = loadPosts()

func loadPosts() -> [Feed] {
    let posts: [Feed] = [
        
        Feed(imageName: "video-promo2"),
        
        Feed(imageName: "Screenshot"),
        
        Feed(imageName: "About us")

        ]
    
    return posts
    
    }
