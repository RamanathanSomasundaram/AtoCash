//
//  RealmHelper.swift
//  Vehicle Tracking
//
//  Created by LKB-L-115 on 15/07/20.
//  Copyright © 2020 LKB-L-115. All rights reserved.
//
//
//import Foundation
//
//class RealmHelper: NSObject {
//    
//    private var realm = AppDelegate.shared.realm!
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    static let shared: RealmHelper = {
//        let instance = RealmHelper()
//        return instance
//    }()
//    
//    //save a message
//    func saveObjectToRealm(_ object: Object){
//        // Query and update from any thread
//        do {
//            try self.realm.safeWrite {
//                self.realm.add(object, update: .all)
//            }
//            try realm.commitWrite()
//        }
//        catch{
//            print("Object write error")
//        }
//    }
//    
////    //Get Project
////    func checkProjectData(projectId : Int) -> offcreateProject? {
////        return realm.objects(offcreateProject.self).filter{ $0.projectId == projectId }.first
////    }
////
////    //Update Project data
////    func updateProject(projectId : Int, vehicleData : List<offcreateVehicle> , locationData : List<offcreateLocation>){
////        let product = checkProjectData(projectId: projectId)
////        if(product == nil) {return}
////        realm.beginWrite()
////        product?.vehicleProject = vehicleData
////        product?.locationData   = locationData
////        try! realm.commitWrite()
////    }
////
////    //Get all project Data
////    func getAllProjectData() -> Results<offcreateProject>?
////    {
////        return realm.objects(offcreateProject.self)
////    }
////
////    func getAllCreateDetail()->Results<offcreateViewDetails>?{
////        return realm.objects(offcreateViewDetails.self).filter("sentStatus == 1")
////    }
////    //Get Save Project
////    func checkSaveData(saveId : String) -> offcreateViewDetails? {
////        return realm.objects(offcreateViewDetails.self).filter("saveId == %@",saveId).first
////    }
//    
////    func saveStatusChange(saveId : String,sendStatus : Int){
////        let product = checkSaveData(saveId: saveId)
////        if(product == nil) {return}
////        realm.beginWrite()
////        product?.sentStatus = sendStatus
////        try! realm.commitWrite()
////    }
////
////    func deleteSentStatus(saveId : String){
////        let product = checkSaveData(saveId: saveId)
////        if(product == nil) {return}
////        realm.beginWrite()
////        realm.delete(product!)
////        try! realm.commitWrite()
////    }
//    
//    //Update Project data
////    func updateSaveData(saveId : String, createViewData : offcreateViewDetails){
////
////        let product = checkSaveData(saveId: saveId)
////        if(product == nil) {return}
////        realm.beginWrite()
////        product?.Activity_Values = createViewData.Activity_Values
////        product?.Creator_ID = createViewData.Creator_ID
////        product?.date = createViewData.date
////        product?.endOD = createViewData.endOD
////        product?.location = createViewData.location
////        product?.Vehicle = createViewData.Vehicle
////        product?.project = createViewData.project
////        product?.refNo = createViewData.refNo
////        product?.Request_ID = createViewData.Request_ID
////        product?.sentStatus = createViewData.sentStatus
////        product?.startOD = createViewData.startOD
////        product?.status = createViewData.status
////        product?.userToken = createViewData.userToken
////        product?.userID = createViewData.userID
////        try! realm.commitWrite()
////    }
////
////    func getBackOfflineData(project : offProject, vehicle : offcreateVehicle, location : offcreateLocation, date : String) -> offcreateViewDetails? {
////        return realm.objects(offcreateViewDetails.self).filter("project.projectId == %d AND Vehicle.vehicleNo == %d AND date == %@ AND location.LocationNo == %d AND sentStatus == %d",project.projectId,vehicle.vehicleNo,date,location.LocationNo,updateStatus.failure.rawValue).first
////    }
////
////    //Get all Activity List
////    func getAllActvityList() -> Results<offcreateActivityList>?
////    {
////        return realm.objects(offcreateActivityList.self)
////    }
////
////    //Update Activity List
////    func checkActivityList(actNo : Int) -> offcreateActivityList? {
////        return realm.objects(offcreateActivityList.self).filter("activityNo == %d",actNo).first
////    }
//    
//    
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//extension Realm {
//    
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    public func safeWrite(_ block: (() throws -> Void)) throws {
//        
//        if (isInWriteTransaction) {
//            try block()
//        } else {
//            try write(block)
//        }
//    }
//}
////-------------------------------------------------------------------------------------------------------------------------------------------------
//extension Results {
//    
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    public func safeObserve(_ block: @escaping (RealmCollectionChange<Results>) -> Void, completion: @escaping (NotificationToken) -> Void) {
//        
//        let realm = try! Realm()
//        if (!realm.isInWriteTransaction) {
//            let token = self.observe(block)
//            completion(token)
//        } else {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                self.safeObserve(block, completion: completion)
//            }
//        }
//    }
//}
