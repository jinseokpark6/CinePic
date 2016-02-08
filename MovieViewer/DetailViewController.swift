//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by WUSTL STS on 2/1/16.
//  Copyright © 2016 jinseokpark. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    
    var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        scrollView.delegate = self

        let title = movie.title
        titleLabel.text = title
        let overview = movie.overview
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        if movie.original_image != "" {
            self.posterImageView.setImageWithURL(movie.original_image)
        } else {
            self.posterImageView.image = UIImage(named: "no_image.png")
        }
        
        
        
        infoView.frame.size.height = overviewLabel.frame.origin.y + overviewLabel.frame.size.height + 5
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.size.height)




        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        self.scrollView.contentOffset.y = 0
        print(self.scrollView.contentOffset.y)

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
