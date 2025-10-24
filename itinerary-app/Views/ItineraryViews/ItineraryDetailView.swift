//
//  ItineraryDetailView.swift
//  itinerary-app
//
//  Created by jhou on 10/24/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ItineraryDetailView: View {
  var itinerary: Itinerary
  @State var saved: Bool
  @State private var detailed: Int = 0
  var body: some View {
    ScrollView {
      if (detailed == 0) {
        // TOP IMAGE OVERLAY
        LocationBannerImage(itinerary: itinerary, saved: saved, hasImage: itinerary.img != nil, height: itinerary.img != nil ? 250 : 100)
        Picker("Type of View", selection: $detailed, content: {
                        Text("Detailed").tag(0)
                        Text("Overview").tag(1)
        }).pickerStyle(SegmentedPickerStyle())
        DetailedView(itinerary: itinerary, saved: saved)
      }
      else {
        LocationBannerImage(itinerary: itinerary, saved: saved, hasImage: itinerary.img != nil, height: itinerary.img != nil ? 250 : 100)
        Picker("Type of View", selection: $detailed, content: {
                        Text("Detailed").tag(0)
                        Text("Overview").tag(1)
        }).pickerStyle(SegmentedPickerStyle())
        SummaryView(itinerary: itinerary, saved: saved)
      }
    }
  }
}

struct DetailedView: View {
  var itinerary: Itinerary
  @State var saved: Bool
  var body: some View {
    VStack {
      LazyVStack(pinnedViews: [.sectionHeaders]) {
        if (itinerary.days != nil) {
          ForEach(itinerary.days!) { day in
            Section(header: HStack {
              Text("Day " + day.dayNumber.description).padding(10).font(.title3).fontWeight(.bold)
              Spacer()
            }.background(Color.white).frame(width: UIScreen.main.bounds.width)
             .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
             ) {
              VStack(alignment: .center) {
                ForEach(day.events!) {
                  event in
                  EventNavView(event: event, itinerary: itinerary)
                }
              }
            }
          }
        }
      }
      Spacer()
    }.frame(maxWidth: .infinity/*, alignment: .topLeading*/)
  }
}

struct SummaryView: View {
  var itinerary: Itinerary
  @State var saved: Bool
  var body: some View {
    VStack {
      LazyVStack(pinnedViews: [.sectionHeaders]) {
        if (itinerary.days != nil) {
          ForEach(itinerary.days!) { day in
            Section(header: HStack {
              Text("Day " + day.dayNumber.description).padding(10).font(.title3).fontWeight(.bold)
              Spacer()
            }.background(Color.white).frame(width: UIScreen.main.bounds.width)
             .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
             ) {
              VStack(alignment: .center) {
                ForEach(day.events!) {
                  event in ShortEventNavView(event: event, itinerary: itinerary)
                }
              }
            }
          }
        }
      }
      Spacer()
    }.frame(maxWidth: .infinity/*, alignment: .topLeading*/)
  }
}



struct LocationBannerImage: View {
  var itinerary: Itinerary
  @State var saved: Bool
  var hasImage: Bool
  var height: CGFloat
  
  var body: some View {
    ZStack(alignment: .topLeading){
      // if it has an image
      if (hasImage) {
        AsyncImage(url: URL(string: itinerary.img ?? "")) { image in image.resizable() } placeholder: { lightBlueColor.opacity(0.9) }
          .frame(width: UIScreen.main.bounds.width, height: height)
          .aspectRatio(contentMode: .fit)
        Rectangle()
          .fill(LinearGradient(
              gradient: .init(colors: [Color.black.opacity(0.9), Color.black.opacity(0.4), Color.white.opacity(0.2), Color.black.opacity(0.3)]),
              startPoint: .init(x: 0.5, y: 0.0),
              endPoint: .init(x: 0.5, y: 1)
          ))
          .frame(width: UIScreen.main.bounds.width, height: height)
        VStack (alignment: .leading){
          Text(itinerary.location).font(.title).fontWeight(.heavy).foregroundColor(Color.white).padding(10).fixedSize(horizontal: false, vertical: true)
          Spacer()
          HStack {
            Spacer()
            if (saved) {
              Button {
              } label: {
                ButtonWithIcon(text: "Saved", systemImage: "checkmark.circle", color: Color.green)
              }
            }
            else {
              Button {
                do {
                  let store = Firestore.firestore()
                  let collectionRef = store.collection("itineraries")
                  let newDocReference = try collectionRef.document(itinerary.id.uuidString).setData(from: itinerary)
                  print("Itinerary stored with new document reference: \(newDocReference)")
                  self.saved = true
                  ItineraryRepository.itineraryRepository.get()
                }
                catch {
                  print("Itinerary save failed with error: \(error)" )
                }
                
              } label: {
                ButtonWithIcon(text: "Save?", systemImage: "questionmark.circle", color: Color.red)
              }
            }
          }
        }
      }
      // else for if no image
      else {
        HStack (){
          Text(itinerary.location).font(.title).fontWeight(.heavy).foregroundColor(Color.black).padding(10).fixedSize(horizontal: false, vertical: true)
          Spacer()
          if (saved) {
            Button {
              
            } label: {
              ButtonWithIcon(text: "Saved", systemImage: "checkmark.circle", color: Color.green)
            }
          }
          else {
            Button {
              do {
                let store = Firestore.firestore()
                let collectionRef = store.collection("itineraries")
                let newDocReference = try collectionRef.document(itinerary.id.uuidString).setData(from: itinerary)
                print("Itinerary stored with new document reference: \(newDocReference)")
                self.saved = true
                ItineraryRepository.itineraryRepository.get()
              }
              catch {
                print("Itinerary save failed with error: \(error)" )
              }
              
            } label: {
              ButtonWithIcon(text: "Save?", systemImage: "questionmark.circle", color: Color.red)
            }
          }
        }
      }
    }.frame(maxHeight: height)
  }
}

struct ButtonWithIcon: View {
  let text: String
  let systemImage: String
  let color: Color
  var body: some View {
    HStack {
      HStack {
        Image(systemName: systemImage)
        Text(text)
      }.padding(10)
    }.background(color).cornerRadius(5).padding(20).foregroundColor(Color.black)
  }
}
