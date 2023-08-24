//
//  DetailOfNewsViewController.swift
//  NewsApp
//
//  Created by Балауса Косжанова on 04.02.2023.
//

import UIKit

class DetailOfNewsViewController: UIViewController {
    var newsContent:ArticleData = ArticleData(author: "", title: "", urlToImage: "", content:"",date: "")

    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var ArticleAuthor: UILabel!
    @IBOutlet weak var ArticleDate: UILabel!
    @IBOutlet weak var ArticleImage: UIImageView!
    
    @IBOutlet weak var ArticleBody: UILabel!
    @IBOutlet weak var ArticleButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        articleName.text = newsContent.title
        ArticleDate.text = "Published in: \(newsContent.date)" 
        ArticleAuthor.text = newsContent.author
        
        if newsContent.urlToImage != nil
        {
            let url = URL(string: newsContent.urlToImage!)
            ArticleImage.downloadImage(from: url!)
            ArticleImage.contentMode = .scaleToFill
            
        }
        else
        {
            ArticleImage.image = UIImage(named:"empty")
        }
        
        ArticleBody.text = newsContent.content
    
 

        // Do any additional setup after loading the view.
    }


    
}
