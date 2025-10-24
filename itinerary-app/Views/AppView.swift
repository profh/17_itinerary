//
//  AppView.swift
//  itinerary-app
//
//  Created by jhou on 11/1/23.
//
import SwiftUI

struct AppView: View {
  @ObservedObject var itineraryRepository = ItineraryRepository.itineraryRepository
  @State private var tabSelection = 0
  @State private var home = UUID()
  @State private var history = UUID()
  @State private var quiz = UUID()
  @State private var tappedTwice: Bool = false
  var handler: Binding<Int> { Binding(
          get: { self.tabSelection },
          set: {
            if ($0 == self.tabSelection) {
              self.tappedTwice = true
            }
            self.tabSelection = $0
          }
  )}
  var body: some View {
    
    TabView(selection: handler) {
      HomeView()
      .tabItem {
          Image(systemName: "globe.europe.africa.fill")
          Text("Home")
      }
      .id(home)
        .onChange(of: tappedTwice, perform: { tappedTwice in
          if (tappedTwice) {
            home = UUID()
            self.tappedTwice = false
          }
        }).tag(0)
      
      HistoryView(/*itineraryRepository: itineraryRepository*/)
      .tabItem {
          Image(systemName: "text.book.closed.fill")
          Text("History")
      }
      .id(history)
      .onChange(of: tappedTwice, perform: { tappedTwice in
        if (tappedTwice) {
          history = UUID()
          self.tappedTwice = false
        }
      }).tag(1)
      
      QuizBeginningView()
      .tabItem {
          Image(systemName: "plus.circle.fill")
          Text("Create Itinerary")
      }.id(quiz)
        .onChange(of: tappedTwice, perform: { tappedTwice in
          if tappedTwice {
            quiz = UUID()
            self.tappedTwice = false
          }
        })
        .tag(2)
    }
  }
}


