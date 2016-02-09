//
//  movieViewController.swift
//  movieViewer
//
//  Created by Shirly Manor on 2/1/16.
//  Copyright © 2016 com.manor. All rights reserved.
//

import UIKit
import AFNetworking

class movieViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieCell: UITableViewCell!
    var movies : [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        print(url)
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //print("response: \(responseDictionary)")
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        })
        task.resume()
        
                
        
        
    

      print("before resume")
 //       task.resume()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies  {
            print(movies.count)
            return (movies.count)
        }
        else{
            return 0
        }

      
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let movie = movies![indexPath.row]
        let title : String = movie["title"] as! String
        let overview : String = movie["overview"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let poster = movie["poster_path"] as! String
        let imageUrl : NSURL = NSURL(string: (baseURL+poster))!
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! MovieCell
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterview.setImageWithURL(imageUrl)
        print(title)
       return cell
    }
   
   }
