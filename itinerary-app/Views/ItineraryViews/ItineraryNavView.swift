//
//  ItineraryRowView.swift
//  itinerary-app
//
//  Created by jhou on 10/24/23.
//

import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift


struct ItineraryNavView: View {
  @ObservedObject var itineraryRepository: ItineraryRepository
  var itinerary: Itinerary
  var sizeHeight: CGFloat
  let sizeWidth: CGFloat = 340
  var isCurrent: Bool
  var saved: Bool
    
  init(itinerary: Itinerary, isCurrent: Bool, saved: Bool, imgURL: URL? = nil/*, itineraryRepository: ItineraryRepository*/) {
    self.itinerary = itinerary
    self.isCurrent = isCurrent
    self.sizeHeight = isCurrent ? 200 : 100
    self.saved = saved
    self.itineraryRepository = ItineraryRepository.itineraryRepository
  }
  
  var body: some View {
    NavigationLink(
      destination: ItineraryDetailView(itinerary: itinerary, saved: saved)) {
        LazyVStack (alignment: .leading, content: {
          ZStack {
            // Image
            if (isCurrent && itinerary.img == nil) {
              Image("default-travel")
                .frame(width: sizeWidth, height: sizeHeight)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .aspectRatio(contentMode: .fill)
                .clipped()
            }
            else if (!isCurrent && itinerary.img == nil) {
              Image("clouds_image")
                .frame(width: sizeWidth, height: sizeHeight)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .aspectRatio(contentMode: .fill)
                .clipped()
            }
            else {
              if let url = URL(string: itinerary.img ?? "") {
                AsyncImage(url: url) { image in image.resizable() } placeholder: { lightBlueColor.opacity(0.9) }
                  .frame(width: sizeWidth, height: sizeHeight)
                  .clipShape(RoundedRectangle(cornerRadius: 20))
                  .aspectRatio(contentMode: .fill)
                  .clipped()
              }
              else {
                Image("clouds_image")
                  .frame(width: sizeWidth, height: sizeHeight)
                  .clipShape(RoundedRectangle(cornerRadius: 20))
                  .aspectRatio(contentMode: .fill)
                  .clipped()
              }
            }
            // Gradient on top of the image
            Rectangle()
                .fill(LinearGradient(
                  gradient: .init(colors: [Color.black.opacity(0.5), Color.white.opacity(0.2), Color.black.opacity(0.2)]),
                  startPoint: .init(x: 0.5, y: 0.0),
                  endPoint: .init(x: 0.5, y: 1)
                ))
                .frame(width: sizeWidth, height: sizeHeight)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            // Text within the button
            HStack {
              if (self.isCurrent) {
                VStack(alignment: .leading) {
                  Text(itinerary.location).frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.white)
                    .font(.title)
                  Spacer()
                  Text(getDurationString(days: itinerary.days?.count ?? 0)).frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.white)
                    .font(.title)
                }.padding(10)
              }
              else {
                VStack(alignment: .leading) {
                  Text(itinerary.location).frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.white)
                    .font(.title3)
                  Spacer()
                  Text(getDurationString(days: itinerary.days?.count ?? 0)).frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.white)
                    .font(.title3)
                }.padding(10)
              }
              Spacer()
              // Menu
              VStack {
                Menu {
                  Button("Set as New Current", action: {
                    let store = Firestore.firestore()
                    // if there's a current itinerary, remove it
                    if let oldCurrentItinerary: Itinerary = itineraryRepository.currentItinerary {
                      let oldCurrentItineraryRef = store.collection("itineraries").document(oldCurrentItinerary.id.uuidString)
                      oldCurrentItineraryRef.updateData([
                        "isCurrent": false
                      ]) { err in
                        if let err = err {
                          print("Error updating document: \(err)")
                        } else {
                          print("Old current itinerary unset as current")
                        }
                      }
                    }
                    // update the new itinerary!
                    let newCurrentItineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
                    newCurrentItineraryRef.updateData([
                      "isCurrent": true
                    ]) { err in
                      if let err = err {
                        print("Error updating document: \(err)")
                      } else {
                        print("Document successfully updated")
                      }
                    }
                  })
                    Button("Delete", role: .destructive) {
                      let store = Firestore.firestore()
                      let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
                      if (itinerary.isCurrent) {
                        itineraryRepository.currentItinerary = nil
                      }
                      itineraryRef.delete() { err in
                        if let err = err {
                          print("Error removing document: \(err)")
                        } else {
                          print("Document successfully removed")
                        }
                      }
                    }
                } label: {
                  Label("", systemImage: "ellipsis.circle").foregroundColor(Color.white)
//                    .border(Color.green , width: 2.0)
                    .font(.system(size: 25))
                }.padding(10)
                Spacer()
              }
            }.frame(alignment: .leading)
          }
        })
        .frame(maxWidth: sizeWidth, maxHeight: sizeHeight)
      }
  }
}
