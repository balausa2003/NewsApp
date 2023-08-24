//
//  ArticleData.swift
//  NewsApp
//
//  Created by Балауса Косжанова on 05.02.2023.
//

import Foundation
struct ArticleData: Codable
{
    let author:String?
    let title:String
    let urlToImage:String?
    let content:String?
    let date:String? 
    
    
}
