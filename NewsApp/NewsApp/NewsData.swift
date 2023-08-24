//
//  NewsData.swift
//  NewsApp
//
//  Created by Балауса Косжанова on 05.02.2023.
//

import Foundation
struct NewsData:Codable
{
    let status:String
    let articles:[ArticleData]
    
}
