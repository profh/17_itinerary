//
//  QuizBeginningView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//



// would I have a navigation link or just a button that moves to next page
//NavigationLink(
   //destination: DurationQuestionView(quiz: quiz)) {

import SwiftUI

struct QuizBeginningView: View {
    var body: some View {
        VStack {
            Text("Journi")
                .fontWeight(.bold)
                .font(.system(size: 30))
                .foregroundStyle(LinearGradient(colors: [.customTan, .customBlush], startPoint: .top, endPoint: .bottom))
            CardView()
         
        }
    }
}
    

