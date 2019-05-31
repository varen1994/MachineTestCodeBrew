//
//  CellWithCollectionView.swift
//  MachineTestCodeBrew
//
//  Created by Varender Singh on 31/05/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit

class CellWithCollectionView: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    enum TypeOfData {
        case recommended
        case featured_localities
        case popularProjects
        case blogsAndArticles
    }
    
    var arrayRecommended = Array<Recommended>()
    var arrayFeatured = Array<FeaturedLocalities>()
    var arrayPopularProjects = Array<PopularProjects>()
    var arrayBlogs = Array<Blogs>()
    
    
    var typeOfView:TypeOfData = .recommended
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUpView() {
        if self.typeOfView == .featured_localities {
            self.labelHeader.text = "Featured Localities"
        }
        else if self.typeOfView == .popularProjects {
            self.labelHeader.text = "Popular Projects"
        }
        else if self.typeOfView == .blogsAndArticles {
            self.labelHeader.text = "Our Blogs and Articles"
        }
        else {
           self.labelHeader.text = "Recommended"
        }
        
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch typeOfView {
          case .featured_localities:
            return arrayFeatured.count;
            
          case .popularProjects:
            return arrayPopularProjects.count;
            
          case .recommended:
              return arrayRecommended.count;
         
          case .blogsAndArticles:
            return arrayBlogs.count;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch typeOfView {
           case .featured_localities:
              let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CellFeaturedLocalitiesIdentifier", for: indexPath)
              let label1 = cell.contentView.viewWithTag(100) as! UILabel
              let label2 = cell.contentView.viewWithTag(102) as! UILabel
              let singleObj = self.arrayFeatured[indexPath.item];
              label1.text = singleObj.name
              if let area = singleObj.price_per_sqft {
                  label2.text = "Square Feet - \(area)"
              }
            return cell;
            
            
        case .blogsAndArticles:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "BlogsAndArticlesIdentifier", for: indexPath);
            let imageView = cell.contentView.viewWithTag(103) as! UIImageView
            let label2 = cell.contentView.viewWithTag(102) as! UILabel
            let label1 = cell.contentView.viewWithTag(101) as! UILabel
            let singleObj = self.arrayBlogs[indexPath.item];
            label2.text = singleObj.meta_description
            label1.text = singleObj.publishedDate
            imageView.image = UIImage.init(named: "DefImage")
         return cell;
            
            
        case .popularProjects:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellIdentifier", for: indexPath)
            let imageView = cell.contentView.viewWithTag(101) as! UIImageView
            let label2 = cell.contentView.viewWithTag(102) as! UILabel
            let singleObj = self.arrayPopularProjects[indexPath.item];
            label2.text = singleObj.name
             imageView.image = UIImage.init(named: "DefImage")
//            if let imageURL = URL.init(string: singleObj.main_image!) {
//
//            }
            return cell;
            
         case .recommended:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellIdentifier", for: indexPath);
             let imageView = cell.contentView.viewWithTag(101) as! UIImageView
            let singleObj = self.arrayRecommended[indexPath.item];
            let label1 = cell.contentView.viewWithTag(102) as! UILabel
            label1.text = singleObj.name;
             imageView.image = UIImage.init(named: "DefImage")
          return cell;
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          switch typeOfView {
            case .blogsAndArticles:
               return CGSize.init(width: 288.0, height: 154.0)
          
          default:
             return CGSize.init(width: 188.0, height: 154.0)
        }
    }
    
    
    
    
    
    
    
}
