//
//  Helpers.swift
//  itinerary-app
//
//  Created by jhou on 11/5/23.
//

import Foundation
import FirebaseStorage
import SwiftUI

func timeTransform(time: String?) -> String {
  if let t = time {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HHmm"
    let dateFromStr = dateFormatter.date(from: t)!

    dateFormatter.dateFormat = "hh:mm a"
    let timeFromDate = dateFormatter.string(from: dateFromStr)
    return timeFromDate
  }
  else { return "Unknown time" }
}

func getURL(path: String?, completion: @escaping (URL) -> Void) {
  if let p = path {
    let storageRef = Storage.storage().reference()
    let starsRef = storageRef.child(p)
    // Fetch the download URL
    
    starsRef.downloadURL(completion: { (url, error) in
      if let error = error {
        // Handle any errors
        print("Error getting download URL: \(error.localizedDescription)")
      } else {
        if let downloadURL = url {
          completion(downloadURL)
        }
      }
    })
  }
}


func getDurationString(days: Int) -> String {
  if (days == 1) {
    return "1 day"
  }
  else if (days < 7) {
    return "\(days) days"
  }
  else if (days == 7) {
    return "1 week"
  }
  else {
    return "\(days / 7) weeks"
  }
}

let lightBlueColor: Color = Color(red: 0.61960784313, green: 0.909803922, blue: 1)
