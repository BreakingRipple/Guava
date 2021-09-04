//
//  WaterfallVC-LoadData.swift
//  Guava
//
//  Created by Savage on 4/9/21.
//

import Foundation
import CoreData

extension WaterfallVC{
    func getDraftNotes(){
        
        let request = DraftNote.fetchRequest() as NSFetchRequest<DraftNote>
        //分页
//        request.fetchOffset = 0
//        request.fetchLimit = 20
        
        //筛选
//        request.predicate = NSPredicate(format: "title = %@", "iOS")
        
        //排序
        let sortDescriptor1 = NSSortDescriptor(key: "updatedAt", ascending: false)
        let sortDescriptor2 = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
//        request.returnsObjectsAsFaults
//        print(draftNotes)
//        print(draftNotes[0].title)
//        print(draftNotes)
        
        request.propertiesToFetch = ["coverPhoto", "title", "updatedAt", "isVideo"]
        
        let draftNotes = try! context.fetch(request)
        self.draftNotes = draftNotes
    }
}
