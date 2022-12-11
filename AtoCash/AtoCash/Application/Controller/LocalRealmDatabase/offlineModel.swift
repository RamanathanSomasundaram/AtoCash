//
//  offlineModel.swift
//  Vehicle Tracking
//
//  Created by LKB-L-115 on 15/07/20.
//  Copyright © 2020 LKB-L-115. All rights reserved.
//
//
//import Foundation
////OfflineModel
//
//class offlineExpenseCreate: Object{
//    dynamic var expenseId : Int = 0
//    @objc dynamic var expenseTitle : String = ""
//    @objc dynamic var currentEmp : Int = 0
//    dynamic var projectId : Int?
//    @objc dynamic var projectName : String?
//    dynamic var subProjectId : Int?
//    @objc dynamic var subProjectName: String?
//    dynamic var taskId : Int?
//    @objc dynamic var taskName : String?
//    
//    //dynamic var  uploadDocument : List<offlineExpenseRecord> = List<offlineExpenseRecord>()
//    
//    convenience init(expenseId : Int,expenseTitle : String, currentEmp : Int,projectId : Int?,projectName : String?,subProjectId : Int?,subProjectName: String?,taskId : Int?,taskName : String?) {
//        self.init()
//        self.expenseId = expenseId
//        self.expenseTitle = expenseTitle
//        self.currentEmp = currentEmp
//        self.projectId = projectId
//        self.projectName = projectName
//        self.subProjectId = subProjectId
//        self.subProjectName = subProjectName
//        self.taskId = taskId
//        self.taskName = taskName
//    }
//    
//    override class func primaryKey() -> String? {
//        return "expenseId"
//    }
//    
//}
////Auto Increment
//func incrementID() -> Int {
//    let realm = try! Realm()
//    return (realm.objects(offlineExpenseCreate.self).max(ofProperty: "expenseId") as Int? ?? 0) + 1
//}
//
//
//
//class offlineExpenseUploadRecord : Object{
//    dynamic var documentId : Int = 0
//    @objc dynamic var actualFileName : String = ""
//    convenience init(documentId : Int, actualFileName : String) {
//        self.init()
//        self.documentId = documentId
//        self.actualFileName = actualFileName
//    }
//    override class func primaryKey() -> String? {
//        return "documentId"
//    }
//}
//
////class offlineExpenseRecord : Object{
////
////    dynamic var  uploadDocument : List<offlineExpenseUploadRecord> = List<offlineExpenseUploadRecord>()
////}
//
//
//

