//
//  ViewController.swift
//  NewsApp
//
//  Created by Балауса Косжанова on 04.02.2023.
//

import UIKit
class ViewController: UIViewController {
    var articlesList = [ArticleData]()
    
    lazy private var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: String(describing: NewsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        newsTableView.frame = view.bounds
        super.viewDidLoad()
        fetch()
        
        view.backgroundColor = .white
        self.title = "News"
        newsTableView.delegate = self
        newsTableView.dataSource = self
        view.addSubview(newsTableView)
        
        
    }
    func fetch() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=dcafe7617eaf475ba25a2768167a647d")
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data , response , error) in
            guard let data = data, error == nil else
            {
                print("Error Occured While Accessing Data with URL")
                return
            }
            var newFullList:NewsData?
            do
            {
                newFullList = try JSONDecoder().decode(NewsData.self, from: data)
            }
            catch {
                print("Error Occured While Decoding JSON into Swift Structure \(error)")
            }
            self.articlesList = newFullList!.articles
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
            
            
        })
        dataTask.resume()
    }
}

extension UIImageView
{
    func downloadImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
          contentMode = mode
          URLSession.shared.dataTask(with: url) { data, response, error in
              guard
                  let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
                  else { return }
              DispatchQueue.main.async() { [weak self] in
                  self?.image = image
              }
          }.resume()
      }
}

extension ViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self)) as! NewsTableViewCell
        if articlesList[indexPath.row].author != nil {
            cell.newsName.text = "\(articlesList[indexPath.row].title)"
        }
        else
        {
            cell.newsName.text = "No Article Available"
        }
        
        cell.newsSeen.text = "192 seen"
        if articlesList[indexPath.row].urlToImage != nil {
            let url = URL(string: articlesList[indexPath.row].urlToImage!) ?? URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fsecret-love&psig=AOvVaw3Ks5z-0ytsPu11CWaTIZjL&ust=1692969865548000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCJC4zK2y9YADFQAAAAAdAAAAABAJ")
            cell.newsImage.downloadImage(from: url!)
            cell.contentMode = .scaleToFill
        }
        else
        {
            cell.newsImage.image = UIImage(named: "emptyimage")
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailOfNewsViewController()
        vc.newsContent = articlesList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

