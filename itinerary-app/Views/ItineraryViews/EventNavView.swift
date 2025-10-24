//
//  EventView.swift
//  itinerary-app
//
//  Created by jhou on 11/5/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EventNavView: View {
  var event: Event
  var itinerary: Itinerary
  @State var navigation: Bool = false
//  @Binding var navigation: Bool = false
  var body: some View {
//    var navigation = false
    switch event.type {
    case .restaurant:
      ZStack {
        NavigationLink(destination: EventDetailView(event: event, itinerary: itinerary), isActive: $navigation) { EmptyView () }
        Menu {
          Button {
            navigation = true
          } label: {
            Text("Details")
          }
          if let url = URL(string: event.url ?? "https://www.google.com/maps") {
            Link(destination: url) {
              Text("Link")
            }
          }
          else {
            if let url = URL(string: "https://www.google.com/maps") {
              Link(destination: url) {
                Text("Link")
              }
            }
          }
          Button("Delete", role: .destructive, action: {
            let store = Firestore.firestore()
            let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
            var newItinerary: Itinerary = itinerary
            for i in 0..<(itinerary.days?.count)! {
              var day = itinerary.days![i]
              for j in 0..<(day.events?.count)! {
                var newEvent = day.events![j]
                if newEvent.id == event.id {
                  newItinerary.days![i].events!.remove(at: j)
                  if newItinerary.days![i].events!.isEmpty {
                    newItinerary.days!.remove(at:i)
                  }
                  newItinerary.lastEditDate = Date()
                  do {
                    try itineraryRef.setData(from: newItinerary)
                    print("worked")
                  } catch let error {
                    print("Error writing to Firestore: \(error)")
                  }
                }
              }
            }

          })
        } label: {
          Meal(event: event).foregroundColor(Color.black)
        }

      }.padding(.bottom, 1).padding(.top, 1)
    case .attraction:
      NavigationLink(destination: EventDetailView(event: event, itinerary: itinerary)) {
        if let imgLink = event.img {
          Attraction(event: event)
        }
        else {
          ShortAttraction(event: event)
        }
      }
    case .geo:
      NavigationLink(destination: EventDetailView(event: event, itinerary: itinerary)) {
        if let imgLink = event.img {
          Attraction(event: event)
        }
        else {
          ShortAttraction(event: event)
        }
      }
    case .travel:
      NavigationLink(destination: EventDetailView(event: event, itinerary: itinerary), isActive: $navigation) { EmptyView () }
      Menu {
        Button {
          navigation = true
        } label: {
          Text("Details")
        }
        if let url = URL(string: event.url ?? "https://www.google.com/maps") {
          Link(destination: url) {
            Text("Link")
          }
        }
        else {
          if let url = URL(string: "https://www.google.com/maps") {
            Link(destination: url) {
              Text("Link")
            }
          }
        }
        Button("Delete", role: .destructive, action: {
          let store = Firestore.firestore()
          let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
          var newItinerary: Itinerary = itinerary
          for i in 0..<(itinerary.days?.count)! {
            var day = itinerary.days![i]
            for j in 0..<(day.events?.count)! {
              var newEvent = day.events![j]
              if newEvent.id == event.id {
                newItinerary.days![i].events!.remove(at: j)
                if newItinerary.days![i].events!.isEmpty {
                  newItinerary.days!.remove(at:i)
                }
                newItinerary.lastEditDate = Date()
                do {
                  try itineraryRef.setData(from: newItinerary)
                  print("worked")
                } catch let error {
                  print("Error writing to Firestore: \(error)")
                }
              }
            }
          }

        })
      } label: {
        Travel(event: event).foregroundColor(Color.black)
      }
    }
  }
}

struct ShortEventNavView: View {
  var event: Event
  var itinerary: Itinerary
  var body: some View {
    NavigationLink(destination: EventDetailView(event: event, itinerary: itinerary)) {
      HStack {
        VStack(alignment: .leading) {
          if (event.timeEnd != nil || event.timeStart != nil) {
            Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
              .font(.title3)
              .foregroundColor(Color.black)
          }
          Text(event.name)
            .font(.title3).fontWeight(.heavy)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color.black)
        }
        Spacer()
        Image(systemName: "chevron.forward.circle")
          .resizable()
          .frame(width: 30, height: 30)
      }.frame(maxWidth: 340, maxHeight: 200)
    }.padding(.bottom, 10).padding(.top, 10)
  }
}


struct Meal: View {
  var event: Event
  var body: some View {
    VStack(alignment: .center) {
      ZStack(alignment: .topLeading){
        Rectangle()
          .fill(lightBlueColor.opacity(0.9))
          .frame(width: 340, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        HStack {
          VStack (alignment: .leading){
            if (event.timeEnd != nil || event.timeStart != nil) {
              Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
                .font(.title3)
            }
            Text("Meal: " + event.name)
              .font(.title3).fontWeight(.heavy)
              .multilineTextAlignment(.leading)
            Spacer()
          }
          Spacer()
          VStack {
            Spacer()
            Image(systemName: "chevron.forward.circle")
              .resizable()
              .frame(width: 30, height: 30)
            Spacer()
          }
        }.padding(10)
      }.frame(maxWidth: 340, maxHeight: 100)
    }
  }
}

struct Attraction: View {
  var event: Event
  var body: some View {
    LazyVStack(alignment: .center) {
      ZStack(alignment: .topLeading){
        AsyncImage(url: URL(string:event.img ?? "")) { image in image.resizable() }
          placeholder: { ProgressView() }
          .frame(width: 340, height: 200)
          .aspectRatio(contentMode: .fit)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Rectangle()
          .fill(LinearGradient(
              gradient: .init(colors: [Color.black.opacity(0.9), Color.black.opacity(0.4), Color.black.opacity(0.1), Color.white.opacity(0.2), Color.black.opacity(0.3)]),
              startPoint: .init(x: 0.5, y: 0.0),
              endPoint: .init(x: 0.5, y: 1)
          ))
          .frame(width: 340, height: 200)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        HStack {
          VStack (alignment: .leading){
            if (event.timeEnd != nil || event.timeStart != nil) {
              Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
                .font(.title3)
                .foregroundColor(Color.white)
            }
            Text(event.name)
              .font(.title3).fontWeight(.heavy)
              .foregroundColor(Color.white).multilineTextAlignment(.leading)
//              .fixedSize(horizontal: false, vertical: true)
            Spacer()
          }/*.padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))*/
          Spacer()
          VStack {
            Spacer()
            Image(systemName: "chevron.forward.circle")
              .resizable()
              .frame(width: 30, height: 30)
              .tint(Color.white)
            Spacer()
          }
        }.padding(10)
      }.frame(maxWidth: 340, maxHeight: 200)
    }
  }
}

struct ShortAttraction: View {
  var event: Event
  var body: some View {
    VStack(alignment: .center) {
      ZStack(alignment: .topLeading){
        Rectangle()
          .fill(Color.customGreenDark)
          .frame(width: 340, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        HStack {
          VStack (alignment: .leading){
            if (event.timeEnd != nil || event.timeStart != nil) {
              Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
                .font(.title3)
                .foregroundColor(Color.black)
            }
            Text(event.name)
              .font(.title3).fontWeight(.heavy)
              .foregroundColor(Color.black).multilineTextAlignment(.leading)
            Spacer()
          }
          Spacer()
          VStack {
            Spacer()
            Image(systemName: "chevron.forward.circle")
              .resizable()
              .frame(width: 30, height: 30)
              .tint(Color.black)
            Spacer()
          }
        }.padding(10)
      }.frame(maxWidth: 340, maxHeight: 100)
    }
  }
}

struct Travel: View {
  var event: Event
  var body: some View {
    HStack {
      Spacer()
      if (event.timeEnd != nil || event.timeStart != nil) {
        Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
          .font(.caption)
      }
      Image(systemName: "ellipsis")
//        .resizable()
        .rotationEffect(.degrees(90))
//        .frame(height: 25)
//        .border(Color.green , width: 2.0)
      Text("Travel: " + event.name)
      Spacer()
      VStack {
        Spacer()
        Image(systemName: "chevron.forward.circle")
          .resizable()
          .frame(width: 30, height: 30)
        Spacer()
      }.padding(10)
    }.frame(maxWidth: 340)
  }
}

