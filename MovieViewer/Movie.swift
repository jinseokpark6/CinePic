//
//  Movie.swift
//  MovieViewer
//
//  Created by WUSTL STS on 2/7/16.
//  Copyright © 2016 jinseokpark. All rights reserved.
//

import UIKit

public class Movie {
    
    public var title: String!
    public var overview: String!
    public var small_image: NSURL!
    public var original_image: NSURL!
    
    init(title: String, overview: String, s_i: NSURL, o_i: NSURL) {
        self.title = title
        self.overview = overview
        self.small_image = s_i
        self.original_image = o_i
    }
    
}
