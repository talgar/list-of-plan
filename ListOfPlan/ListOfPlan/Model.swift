//
//  Model.swift
//  ListOfPlan
//
//  Created by admin on 20.06.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

var toDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "toDoDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "toDoDataKey") as? [[String: Any]]  {
            return array
        } else {
            return []
        }
    }
}

var des: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "toDoDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array2 = UserDefaults.standard.array(forKey: "toDoDataKey") as? [[String: Any]]  {
            return array2
        } else {
            return []
        }
    }
}

func addItem(nameItem : String, isCompleted : Bool = false)  {
    toDoItems.append(["Name": nameItem, "isCompleted": isCompleted])
    setBadge()
}

func removeItem(at Index : Int) {
    toDoItems.remove(at: Index)
    setBadge()
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = toDoItems[fromIndex]
    toDoItems.remove(at: fromIndex)
    toDoItems.insert(from, at: toIndex)
}
func changeState(at item: Int) -> Bool {
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return toDoItems[item]["isCompleted"] as! Bool
}

func requestForNotificstion( ) {
    UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (isEnabled, error) in
    }
}

func setBadge( ) {
    
    var totalBadgeNumber = 0
    for i in toDoItems {
        if (i["isCompleted"] as? Bool) == false {
            totalBadgeNumber += 1
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}

