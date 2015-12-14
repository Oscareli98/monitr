//
//  ArticleCollectionViewCell.swift
//  
//
//  Created by Oscar Newman on 12/12/15.
//
//

import UIKit
import Kingfisher

class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var articleTitleLabel: UILabel!
    @IBOutlet var gradientView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    func configureCell(article: Article) {
        if let title = article.title {
            self.articleTitleLabel.text = title
        }
        
        if let url = article.imageURL {
            self.articleImageView.kf_setImageWithURL(url)
        }
        
        if let date = article.datePosted {
            self.dateLabel.text = "• \(date.timeAgoSinceDate(true))"
        }
        
        
    }
    
    override func awakeFromNib() {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clearColor(), UIColor(white: 0, alpha: 0.7)]
        layer.locations = [0, 1]
        gradientView.layer.insertSublayer(layer, atIndex: 0)
        
        self.clipsToBounds = true
    }
    
}
