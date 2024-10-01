//
//  PostModel.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import Foundation


struct PostModel : Codable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}
