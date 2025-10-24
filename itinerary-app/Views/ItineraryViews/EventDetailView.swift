//
//  EventDetailView.swift
//  itinerary-app
//
//  Created by jhou on 11/5/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

func hourMinFromStr(time: String?, offset1: Int, offset2: Int) -> Int? {
  if let time = time {
    var str = time[String.Index(utf16Offset: offset1, in: time)..<String.Index(utf16Offset: offset2, in: time)]
    print(str)
    if var strInt = Int(str) {
      if strInt > 12 {
        strInt -= 12
      }
      return strInt
    }
    else {
      return Int(str)
    }
  }
  return nil
}
struct EventDetailView: View {
  @State var event: Event
  @State var itinerary: Itinerary
  @State var editing: Bool = false
//  @State var notes: event.note
  //  var dayEvent: (Int, Int)
  var body: some View {
    if !editing {
        //    let day = dayEvent.0
        //    let eventNum = dayEvent.1
        VStack(alignment: .center) {
          HStack {
            Text(event.name).font(.title).fontWeight(.heavy)/*.frame(alignment: .leading)/*.padding(20)*/*/
            if let url = event.url {
              if let convertedUrl = URL(string:url) {
                Link(destination: convertedUrl) { Image(systemName: "link") }
              }
            }
          }
          
          if let imgLink = event.img {
            AsyncImage(url: URL(string: imgLink)) { image in image.resizable() }
          placeholder: { Color.blue.opacity(0.7) }
              .frame(width: UIScreen.main.bounds.width, height: 250)
              .aspectRatio(contentMode: .fit).frame(maxWidth: .infinity)
          }
          VStack(alignment: .leading) {
            Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
              .font(.title3).fontWeight(.bold).padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Text(event.description ?? "")
            HStack {
              Spacer()
              Button("Edit") { editing = true }
              Spacer()
              Button("Delete", role: .destructive) {
                let store = Firestore.firestore()
                let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
                var newItinerary: Itinerary = itinerary
                for i in 0..<(itinerary.days?.count)! {
                  var day = itinerary.days![i]
                  for j in 0..<(day.events?.count)! {
                    var newEvent = day.events![j]
                    if newEvent.id == event.id {
                      newItinerary.days![i].events!.remove(at: j)
                      //                newItinerary.days![i].events![j].name="Testing12345"
                      if newItinerary.days![i].events!.isEmpty {
                        newItinerary.days!.remove(at:i)
                      }
                      newItinerary.lastEditDate = Date()
                      //                newEvent.name = "Testing12345"
                      do {
                        try itineraryRef.setData(from: newItinerary)
                        print("worked")
                      } catch let error {
                        print("Error writing city to Firestore: \(error)")
                      }
                      //                navStateManager.path = NavigationPath()
  //                    path.removeLast()
  //                    path = NavigationPath()
                    }
                  }
                }
              }
              Spacer()
            }
            TextField("Personal notes", text: $event.notes.toUnwrapped(defaultValue: ""),  axis: .vertical)
                .lineLimit(5...15)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )
//                .onChange(of: event.notes) { notes in
//                  var saveEvent = event
//                  let store = Firestore.firestore()
//                  let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
//                  var newItinerary: Itinerary = itinerary
//                  for i in 0..<(itinerary.days?.count)! {
//                    var day = itinerary.days![i]
//                    for j in 0..<(day.events?.count)! {
//                      var newEvent = day.events![j]
//                      if newEvent.id == event.id {
//                        newItinerary.days![i].events![j] = saveEvent
//                        newItinerary.lastEditDate = Date()
//                        print(newItinerary)
//                        do {
//                          try itineraryRef.setData(from: newItinerary)
//                        } catch let error {
//                          print("Error writing city to Firestore: \(error)")
//                        }
//                      }
//                    }
//                  }
//                }
            Button("Save Notes") {
              let saveEvent = event
              let store = Firestore.firestore()
              let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
              var newItinerary: Itinerary = itinerary
              for i in 0..<(itinerary.days?.count)! {
                var day = itinerary.days![i]
                for j in 0..<(day.events?.count)! {
                  var newEvent = day.events![j]
                  if newEvent.id == event.id {
                    newItinerary.days![i].events![j] = saveEvent
                    newItinerary.lastEditDate = Date()
                    print(newItinerary)
                    do {
                      try itineraryRef.setData(from: newItinerary)
                    } catch let error {
                      print("Error writing city to Firestore: \(error)")
                    }
                  }
                }
              }
            }
          }.frame(maxWidth: 340, alignment: .center)/*.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))*/
        
          
          Spacer()
          
        }
        
        
        
      }
      else {
        EditItineraryEvent(event: $event, itinerary: itinerary, editing: $editing, 
                           startTimeHour: hourMinFromStr(time: event.timeStart, offset1: 0, offset2: 2),
                           startTimeMinute: hourMinFromStr(time: event.timeStart, offset1: 2, offset2: 4),
                           endTimeHour: hourMinFromStr(time: event.timeEnd, offset1: 0, offset2: 2),
                           endTimeMinute:hourMinFromStr(time: event.timeEnd, offset1: 2, offset2: 4),
                           timeStart: AMPM(time: event.timeStart),
                           timeEnd: AMPM(time: event.timeEnd)
        )
      }
      
    }
  func AMPM(time: String?) -> TimeOptions{
    if let time = time {
      let str = time[String.Index(utf16Offset: 0, in: time)..<String.Index(utf16Offset: 2, in: time)]
      if let intStr = Int(str) {
        return intStr >= 12 ? TimeOptions.PM : TimeOptions.AM
      }
    }
    return TimeOptions.AM
  }
}
  

extension EventType {
  static var allCases: [EventType] {
    return [.restaurant, .geo, .attraction, .travel]
      }
}
enum TimeOptions: String {
    case AM = "AM"
    case PM = "PM"
  static var allCases: [TimeOptions] {
    return [.AM, .PM]
  }
}

struct EditItineraryEvent: View {
  @Binding var event: Event
  @State var itinerary: Itinerary
  @Binding var editing: Bool
  @State var startTimeHour: Int?
  @State var startTimeMinute: Int?
  @State var endTimeHour: Int?
  @State var endTimeMinute: Int?
  @State var timeStart: TimeOptions
  @State var timeEnd: TimeOptions
  var body: some View {
    let origEvent = event
    VStack {
      Form {
        Section(header: Text("Event Details")) {
          TextField("Event name", text: $event.name ).fontWeight(.heavy).multilineTextAlignment(.leading)
          TextField("Description", text: $event.description.toUnwrapped(defaultValue: ""))
        }
        
        Section(header: Text("Start and End Times")) {
          Picker("Start Hour", selection: Binding($startTimeHour, deselectTo: nil)) {
            Text("None").tag(nil as Int?)
            ForEach(1...12, id: \.self) { number in
                Text("\(number)").tag(number as Int?)
            }
          }
          if (startTimeHour != nil) {
            Picker("Start Minute", selection: $startTimeMinute) {
                ForEach(0...59, id: \.self) { number in
                    Text("\(number)").tag(number as Int?)
                }
            }
          }
          Picker("AM/PM", selection: $timeStart) {
            ForEach(TimeOptions.allCases, id: \.self) { option in
              Text(option.rawValue)
            }
          }.pickerStyle(SegmentedPickerStyle())
          Picker("End Hour", selection: $endTimeHour) {
            Text("None").tag(nil as Int?)
              ForEach(1...12, id: \.self) { number in
                  Text("\(number)").tag(number as Int?)
              }
          }
          if (endTimeHour != nil) {
            Picker("End Minute", selection: $endTimeMinute) {
                ForEach(0...59, id: \.self) { number in
                    Text("\(number)").tag(number as Int?)
                }
            }
          }
          Picker("AM/PM", selection: $timeEnd) {
            ForEach(TimeOptions.allCases, id: \.self) { option in
              Text(option.rawValue)
            }
          }.pickerStyle(SegmentedPickerStyle())
        }

        Section(header: Text("Other Information")) {
          Picker("Event type", selection: $event.type) {
            ForEach(EventType.allCases, id: \.self) { option in
              Text(option.rawValue)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          TextField("Link", text: $event.url.toUnwrapped(defaultValue: "")).autocapitalization(.none)
          TextField("Image Link", text: $event.img.toUnwrapped(defaultValue: "")).autocapitalization(.none)
        }
        
        HStack {
          Button("Revert to original") {
            event.name = origEvent.name
            event.description = origEvent.description
            event.type = origEvent.type
            event.url = origEvent.url
            event.img = origEvent.img
            editing = false
            print("discard")
          }
          Spacer()
          Button("Save") {
            editing = false
            var saveEvent = event
            var startOffset: Int
            var endOffset: Int
            if timeStart == TimeOptions.PM {
              startOffset = 12
            } else { startOffset = 0 }
            if timeEnd == TimeOptions.PM {
              endOffset = 12
            } else { endOffset = 0 }
            saveEvent.name = event.name
            saveEvent.description = event.description
            saveEvent.type = event.type
            if (event.url == "") {
              saveEvent.url = nil
            } else { saveEvent.url = event.url }
            if (event.img == "") {
              saveEvent.img = nil
            } else { saveEvent.img = event.img }
            if var startTimeHour = startTimeHour {
              startTimeHour += startOffset
              var str = String(startTimeHour)
              if startTimeHour < 10 {
                str = "0" + str
              }
              if let minute = startTimeMinute {
                if minute < 10 {
                  str = str + "0"
                }
                str = str + String(minute)
              }
              else {
                str = str + "00"
              }
                            
              saveEvent.timeStart = str
            }
            else {
              saveEvent.timeStart = nil
            }
            if var endTimeHour = endTimeHour {
              endTimeHour += endOffset
              
              var str = String(endTimeHour)
              if endTimeHour < 10 {
                str = "0" + str
              }
              if let minute = endTimeMinute {
                if minute < 10 {
                  str = str + "0"
                }
                str = str + String(minute)
              }
              else {
                str = str + "00"
              }
              
              saveEvent.timeEnd = str
            }
            else {
              saveEvent.timeEnd = nil
            }
            print(saveEvent)
            let store = Firestore.firestore()
            let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
            var newItinerary: Itinerary = itinerary
            for i in 0..<(itinerary.days?.count)! {
              var day = itinerary.days![i]
              for j in 0..<(day.events?.count)! {
                var newEvent = day.events![j]
                if newEvent.id == event.id {
                  newItinerary.days![i].events![j] = saveEvent
                  newItinerary.lastEditDate = Date()
                  print(newItinerary)
                  do {
                    try itineraryRef.setData(from: newItinerary)
                  } catch let error {
                    print("Error writing city to Firestore: \(error)")
                  }
                }
              }
            }
          }
        }.buttonStyle(BorderlessButtonStyle())
      }
    }

//    VStack {
////      NavigationLink(destination: EventNavView(event: event, itinerary: itinerary)) {
////        Text("dsfklj")
////      }
////      TextField("Event name", text: $event.name ).fontWeight(.heavy).multilineTextAlignment(.leading)
////      TextField("Name", text: $event.name )
////      TextField("Description", text: $event.description.toUnwrapped(defaultValue: ""))
////      TextField("Name", text: $event.name )
//
//
//    }.frame(maxWidth: 340)
  }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

public extension Binding where Value: Equatable {
  init(_ source: Binding<Value>, deselectTo value: Value) {
    self.init(get: { source.wrappedValue },
              set: { source.wrappedValue = $0 == source.wrappedValue ? value : $0 }
    )
  }
}
