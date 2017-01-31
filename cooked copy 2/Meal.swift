//
//  Meal.swift
//  Cooked
//
//  Created by jbartle4 on 10/26/16.
//  Copyright © 2016 jbartle4. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var desc: String
    var origin: String
    var category: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let descKey = "desc"
        static let originKey = "origin"
        static let categoryKey = "category"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    // MARK: Initialization
    
    init?(name: String, desc: String, origin: String, category: String, photo: UIImage?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.desc = desc
        self.origin = origin
        self.category = category
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || desc.isEmpty || origin.isEmpty || category.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(desc, forKey: PropertyKey.descKey)
        aCoder.encode(origin, forKey: PropertyKey.originKey)
        aCoder.encode(category, forKey: PropertyKey.categoryKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        let desc = aDecoder.decodeObject(forKey: PropertyKey.descKey) as! String
        
        let origin = aDecoder.decodeObject(forKey: PropertyKey.originKey) as! String
        
        let category = aDecoder.decodeObject(forKey: PropertyKey.categoryKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
        
        // Must call designated initializer.
        self.init(name: name, desc: desc, origin: origin, category: category, photo: photo, rating: rating)
    }
    
}
