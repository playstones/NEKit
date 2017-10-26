//
//  Logger.swift
//  NEKit
//
//  Created by lei on 2017/6/27.
//  Copyright © 2017年 Zhuhao Wang. All rights reserved.
//
import Foundation


public protocol LoggerDelegate {
    func recerved(log :String)
}

public struct LogInfo {
    
    public let ceateDate : Date
    public let info : String
    public let uuid : String
    
    public func dictionary() -> [String:Any] {
        return ["Date": self.ceateDate, "Info":self.info, "UUID":self.uuid]
    }
    
    public init(ceateDate: Date, info: String, uuid: String) {
        self.ceateDate = ceateDate
        self.info = info
        self.uuid = uuid
    }
    
    public  init(dic:[String:Any]) {
        self.ceateDate = dic["Date"] as? Date ?? Date()
        self.info = dic["Info"] as? String ?? ""
        self.uuid = dic["UUID"] as? String ?? ""
    }
}

open class Logger: NSObject {
    
    open static let share = Logger()
    
    open var observer : [LoggerDelegate] = []
    
    fileprivate override init() {}
    
    func log(message:String) {
        _ = observer.map {$0.recerved(log: message)}
    }

}
