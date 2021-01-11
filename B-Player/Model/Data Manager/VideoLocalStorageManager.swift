//
//  LocalStorageManager.swift
//  B-Player
//
//  Created by user on 09/01/21.
//
import CoreData
import Foundation
import UIKit
class VideoLocalDBManager {
    static let sharedManager = VideoLocalDBManager()
    
    var appdelegate:AppDelegate  {
        let appDelegate: AppDelegate
        if Thread.current.isMainThread {
            appDelegate = UIApplication.shared.delegate as! AppDelegate
        } else {
            appDelegate = DispatchQueue.main.sync {
                return UIApplication.shared.delegate as! AppDelegate
            }
        }
        return appDelegate
        
    }
    
    func save(videos:[VideoData],completion:(Bool)->Void) {
        let viewContext = appdelegate.persistentContainer.viewContext
        
        videos.forEach { (video) in
            let videoLocal = Video(context: viewContext)
            
            videoLocal.id = video.id
            videoLocal.title = video.title
            videoLocal.vdescription = video.description
            videoLocal.url = video.url
            videoLocal.thumbnail = video.thumb
            videoLocal.currentTime = 0.0
            
            
        }
        do {
            try viewContext.save()
            completion(true)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    func getFromLocal(completion:@escaping(_ result:[Video]?,_ status:Error?)->Void)
    {
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Video>  = Video.fetchRequest()
        let nameSort = NSSortDescriptor(key:"id", ascending:true)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.sortDescriptors = [nameSort]
        do {
            
            let result =  try context.fetch(fetchRequest)
            completion(result, nil)
        } catch let error {
            print("error: \(error)")
            completion(nil,error)
        }
        
    }
    
    func entityIsEmpty() -> Bool
    {
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Video>(entityName: "Video")
        
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0
            {
                return true
            }
            else
            {
                return false
            }
        }
        catch{
            
            return false
        }
        
    }
    
    
    func saveChanges() {
        let viewContext = appdelegate.persistentContainer.viewContext
        if(viewContext.hasChanges) {
            do {
                try viewContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
    // MARK:- Private Methods for setting address and company
    
    
    
    
    
    
    
}
