//
//  MovieCell.swift
//  MovieViewer
//
//  Created by WUSTL STS on 1/27/16.
//  Copyright © 2016 jinseokpark. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

}

extension MovieCell {
    func fadeOut() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.posterView.alpha = 0.3
            self.titleLabel.alpha = 1.0
            self.descriptionLabel.alpha = 1.0
        })
    }
    func fadeIn() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.posterView.alpha = 1.0
            self.titleLabel.alpha = 0.0
            self.descriptionLabel.alpha = 0.0
        })
    }
}