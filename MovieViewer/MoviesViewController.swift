//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by WUSTL STS on 1/26/16.
//  Copyright © 2016 jinseokpark. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [NSDictionary]?
    var filteredData: [NSDictionary]!
    
    var leftEdge: CGFloat?
    var rightEdge: CGFloat?
    var topEdge: CGFloat?
    var bottomEdge: CGFloat?
    
    var detailCellPath: NSIndexPath?
    var refreshControl: UIRefreshControl!
    var refreshLoadingView: UIView!
    
    var fumes: UIImageView!
    var mountain: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        // Hide errorView upon loading
        errorView.hidden = true


        setupRefreshControl()

        // Refresh upon loading
        refreshControlAction(refreshControl)
        
        // Initialize edges
        leftEdge = 8.0
        rightEdge = 8.0
        topEdge = 4.0
        bottomEdge = 4.0

    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            
                            self.errorView.hidden = true
                            // Hide HUD once the network request comes back (must be done on main UI thread)
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            
                            self.data = responseDictionary["results"] as! [NSDictionary]
                            
                            self.filteredData = self.data
                            
                            self.collectionView.reloadData()
                            
                            refreshControl.endRefreshing()
                    }
                } else {
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        self.errorView.hidden = false
                        }, completion: nil)
                }
        })
        task.resume()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = filteredData![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            cell.posterView.setImageWithURL(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            cell.posterView.image = nil
        }
        
        
        cell.posterView.alpha = 0.0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            cell.posterView.alpha = 1.0
            })
        cell.titleLabel.text = title
        cell.descriptionLabel.text = overview
        cell.titleLabel.alpha = 0.0
        cell.descriptionLabel.alpha = 0.0

        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let filteredData = filteredData {
            return filteredData.count
        } else {
            return 0
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MovieCell
        if detailCellPath == nil {
            cell.fadeOut()
            detailCellPath = collectionView.indexPathForCell(cell)
        } else {
            if cell.posterView.alpha == 1.0 {
                if let prevCell = collectionView.cellForItemAtIndexPath(detailCellPath!) as? MovieCell {
                    prevCell.fadeIn()
                }
                cell.fadeOut()
                detailCellPath = collectionView.indexPathForCell(cell)
            } else {
                cell.fadeIn()
                detailCellPath = nil
            }
        }

    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        let itemWidth = (viewWidth - 2.0) / 2
        let itemHeight = (itemWidth) * 1.4 - 1.0
        var itemSize = CGSizeMake(itemWidth, itemHeight)
        return itemSize
    }

    
    
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filteredData = data
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            
            var titleData: [String] = [String]()
            for movie in data! {
                titleData.append(movie["title"] as! String)
            }
            
            filteredData = data!.filter({(dataItem: NSDictionary) -> Bool in
                // If dataItem's title matches the searchText, return true to include it
                if let title = dataItem["title"] as? String {
                    if title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                        return true
                    } else {
                        return false
                    }
                }
                // If dataItem does not have a title
                return false
            })
        }
        collectionView.reloadData()
    }
    
    func setupRefreshControl() {
        
        // Programmatically inserting a UIRefreshControl
        self.refreshControl = UIRefreshControl()
        
        // Setup the loading view, which will hold the moving graphics
        self.refreshLoadingView = UIView(frame: self.refreshControl!.bounds)
//        self.refreshLoadingView.backgroundColor = UIColor.clearColor()
        
        // Setup the color view, which will display the rainbowed background
//        self.refreshColorView = UIView(frame: self.refreshControl!.bounds)
//        self.refreshColorView.backgroundColor = UIColor.clearColor()
//        self.refreshColorView.alpha = 0.30
        
        // Create the graphic image views
//        let width = self.view.frame.width
//        let height = self.refreshLoadingView.frame.height
//        self.fumes = UIImageView()
//        self.fumes.frame.size = CGSize(width: 60, height: 30)
//        self.fumes.center = CGPoint(x: width/2, y: height/2 - 20)
//        self.fumes.image = UIImage(named: "fumes.png")
//        self.mountain = UIImageView()
//        self.mountain.frame.size = CGSize(width: 60, height: 30)
//        self.mountain.center = CGPoint(x: width/2, y: height/2 + 10)
//        self.mountain.image = UIImage(named: "mountain.png")
//        
//        // Add the graphics to the loading view
//        self.refreshLoadingView.addSubview(self.fumes)
//        self.refreshLoadingView.addSubview(self.mountain)
//        
//        // Clip so the graphics don't stick out
//        self.refreshLoadingView.clipsToBounds = true;
//        
//        // Hide the original spinner icon
//        self.refreshControl!.tintColor = UIColor.clearColor()
//        
//        // Add the loading and colors views to our refresh control
////        self.refreshControl!.addSubview(self.refreshColorView)
//        self.refreshControl!.addSubview(self.refreshLoadingView)
        
        // Initalize flags
//        self.isRefreshIconsOverlap = false;
//        self.isRefreshAnimating = false;
        
        // When activated, invoke our refresh function
//        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)

        // Initialize a UIRefreshControl
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)

    }
    
    func refresh() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
