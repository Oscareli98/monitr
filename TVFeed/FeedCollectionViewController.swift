//
//  HomeCollectionViewController.swift
//  TVFeed
//
//  Created by Oscar Newman on 12/12/15.
//  Copyright © 2015 Oscar Newman. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reuseIdentifier = "articleCell"

class FeedCollectionViewController: UICollectionViewController {

    var articles: [Article] = []
    
    let cellSizeThird = CGSizeMake(640, 1080)
    let cellSizeTwoThirds = CGSizeMake(1280, 1080)
    let cellSizeThirdHalfHeight = CGSizeMake(640, 540)
    let cellSizeFull = CGSizeMake(1920, 1080)
    
    var currentItem = NSIndexPath(forItem: 0, inSection: 0)


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        APIService.sharedInstance.getNYT({articles in
            self.articles = articles as! [Article]
            self.collectionView?.reloadData()
        }, failure: {_,_,_ in
        
        })
        

        // Do any additional setup after loading the view.
        NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "scrollToNext", userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return articles.count
    }
    

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? ArticleCollectionViewCell {
            
            cell.configureCell(articles[indexPath.row])
            return cell
            
        } else {
            return ArticleCollectionViewCell()
        }
        
        
        
//        cell.articleTitleLabel.text = articles[indexPath.row].title

    
        // Configure the cell
    
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let mod = indexPath.row % 9

        switch mod {
        case 0:
            return cellSizeTwoThirds
        case 1,2:
            return cellSizeThirdHalfHeight
        case 3,4,5,6:
            return cellSizeThird
        case 7:
            return cellSizeTwoThirds
        case 8:
            return cellSizeFull
        default:
            return cellSizeThird
        }
    }
    
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func scrollToNext() {
        var nextItem = NSIndexPath(forItem: currentItem.row + 1, inSection: currentItem.section)
        if currentItem.row == articles.count - 1 {
            nextItem = NSIndexPath(forItem: 0, inSection: 0)
            currentItem = nextItem
            APIService.sharedInstance.getNYT({articles in
                self.articles = articles as! [Article]
                self.collectionView?.reloadData()
                self.collectionView?.scrollToItemAtIndexPath(nextItem, atScrollPosition: .Left, animated: true)
                }, failure: {_,_,_ in
                    
            })
            return
        }
        currentItem = nextItem
        
        
        self.collectionView?.scrollToItemAtIndexPath(nextItem, atScrollPosition: .Left, animated: true)
    }
    
//    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
//        if let previousItem = context.previouslyFocusedView as? ArticleCollectionViewCell {
//            UIView.animateWithDuration(0.2, animations: { () -> Void in
//                (previousItem.gradientView.layer.sublayers![0] as! CAGradientLayer).colors![1] = UIColor(white: 0, alpha: 0.7)
//            })
//        }
//        if let nextItem = context.nextFocusedView as? ArticleCollectionViewCell {
//            UIView.animateWithDuration(0.2, animations: { () -> Void in
//                (nextItem.gradientView.layer.sublayers![0] as! CAGradientLayer).colors![1] = UIColor(white: 0, alpha: 1)
//            })
//        }
//        
//    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension FeedCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}
