//
//  ViewController.swift
//  Tumblr
//
//  Created by Jay Liew on 10/12/16.
//  Copyright © 2016 Jay Liew. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    
}

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var allPosts: [Any]?
    
    func refreshControlAction(refreshControl: UIRefreshControl) {

        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/ultrafunnypictures.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                
                if let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
                    let response = json["response"] as! [String: Any]
                    
                    if let posts = response["posts"] as? [Any] {
                        self.allPosts = posts
                        //print(posts)
                        self.tableView.reloadData()
                        
                    }
                }
            }
        });
        task.resume()
        
        refreshControl.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 320.0 //CGFloat(320)
        
        
        
        callAPI()
        let refreshControl = UIRefreshControl()
        //refreshControl.addTarget(self, action: Selector(("refreshControlAction:")), for: UIControlEvents.valueChanged)
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
    
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        
        
        if let post = self.allPosts?[(indexPath?.row)!] as? [String: Any]{
            if let photos = post["photos"] as? [Any] {
                if let photos_zero = photos[0] as? [String: Any]{
                    if let alt_sizes = photos_zero["alt_sizes"] as? [Any]{
                        if let first_pic = alt_sizes[0] as? [String: Any]{
                            if let url = first_pic["url"] as? String {
                                
                                print("URLLLLLL \(url)")
                                vc.url = url
  //                              vc.photoView.setImageWith(URL(string: url)!)
                                
                            }
                        }
                    }
                }
            }
        }

        
        
        
        
        //print("INDEXXXPATHHHHH \(indexPath)")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = self.allPosts {
            print("COUNT !!!! \(posts.count)")
            return posts.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        //cell.textLabel?.text = data[indexPath.row]
        
        if let post = self.allPosts?[indexPath.row] as? [String: Any]{
            if let photos = post["photos"] as? [Any] {
                if let photos_zero = photos[0] as? [String: Any]{
                    if let alt_sizes = photos_zero["alt_sizes"] as? [Any]{
                        if let first_pic = alt_sizes[0] as? [String: Any]{
                            if let url = first_pic["url"] as? String {
                                cell.photoView.setImageWith(URL(string: url)!)
                            }
                        }
                    }
                }
            }
        }
        
        
        
        return cell
    }
    
    func callAPI (){
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                
                    if let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
                        let response = json["response"] as! [String: Any]
                       
                        if let posts = response["posts"] as? [Any] {
                            self.allPosts = posts
                            //print(posts)
                            self.tableView.reloadData()
                            
                        }
                    }
            }
        });
        task.resume()
        
        print(url)
    }

}

