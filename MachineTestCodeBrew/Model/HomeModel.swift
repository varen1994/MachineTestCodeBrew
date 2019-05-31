//
//  HomeModel.swift
//  MachineTestCodeBrew
//
//  Created by Varender Singh on 31/05/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit

class HomeModel: NSObject {

    var featured_localities = Array<FeaturedLocalities>();
    var recommended = Array<Recommended>()
    var popularProjects = Array<PopularProjects>()
    var blogs = Array<Blogs>()
    
    init(response:NSDictionary) {
        guard let data = response.value(forKey: "data") as? NSDictionary else {
            return ;
        }
        
        if let blogs = data.value(forKey: "blogs") as? NSArray {
            for dictionary in blogs {
                let newDict = dictionary as! NSDictionary
                let image = newDict.value(forKey: "image") as? String
                let metaData = newDict.value(forKey: "meta_description") as? String
                let publishedDate = newDict.value(forKey: "publish_date") as? String
                let obj = Blogs.init(image: image, publishedDate: publishedDate, meta_description: metaData)
                self.blogs.append(obj)
            }
        }
        
        
        if let popularProjects = data.value(forKey: "popular_projects") as? NSArray {
             for dictionary in popularProjects {
                let newDict = dictionary as! NSDictionary
                let name = newDict.value(forKey: "name") as? String
                let main_image = newDict.value(forKey: "main_image") as? String
                let obj = PopularProjects.init(name: name, main_image: main_image)
                self.popularProjects.append(obj);
            }
        }
        
        if let recommended = data.value(forKey: "recommended") as? NSArray {
            for dictionary in recommended {
               let newDict = dictionary as! NSDictionary
                let name = newDict.value(forKey: "name") as? String
                let image = newDict.value(forKey: "image") as? String
                let obj = Recommended.init(name: name, image: image);
                self.recommended.append(obj);
            }
        }
        
        
        if let featured_localities = data.value(forKey: "featured_localities") as? NSArray {
            for dictionary in featured_localities {
                let newDict = dictionary as! NSDictionary
                 let name_en = newDict.value(forKey: "name_en") as? String
                 let name = newDict.value(forKey: "name") as? String
                 let price_per_sqft = newDict.value(forKey: "price_per_sqft") as? Int
                let obj = FeaturedLocalities.init(name_en: name_en, price_per_sqft: price_per_sqft, name: name)
                self.featured_localities.append(obj);
            }
        }
        
    }
}

struct Blogs {
    var image:String?
    var publishedDate:String?
    var meta_description:String?
}

struct PopularProjects {
    var name:String?
    var main_image:String?
}


struct Recommended {
    var name:String? = nil;
    var image:String? = nil;
}

struct FeaturedLocalities {
    var name_en:String?
    var price_per_sqft:Int?
    var name:String?
    
}
