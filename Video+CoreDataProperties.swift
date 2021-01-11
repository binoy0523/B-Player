//
//  Video+CoreDataProperties.swift
//  
//
//  Created by user on 10/01/21.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var vdescription: String?
    @NSManaged public var id: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var currentTime: Float

}
