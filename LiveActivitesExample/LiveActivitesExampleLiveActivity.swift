//
//  LiveActivitesExampleLiveActivity.swift
//  LiveActivitesExample
//
//  Created by Kevin Cheung on 3/13/24.
//

#if canImport(ActivityKit)
import ActivityKit
#endif
import WidgetKit
import SwiftUI

struct LiveActivitesExampleAttributes: ActivityAttributes {
    
    public struct ContentState: Codable, Hashable {
        var teamOneScore: Int
        var teamTwoScore: Int
    }
    
    var gameName: String
    var gameNumber: String
    
}

struct LiveActivitesExampleLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitesExampleAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.white) // ZStack for background to be white with custom color overlay
                    HStack {
                        // Left team's logo
                        Image("celtics-logo")
                            .resizable()
                            .frame(width: 70, height: 60)
                        
                        Text("\(context.state.teamOneScore)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 16/255, green: 57/255, blue: 71/255))
                            .padding(.trailing, 60) // Adjusted padding for the left side of the score
                        VStack {
                            Image("live-symbol")
                                .resizable()
                                .frame(width: 45, height: 40)
                            
                            let startDate = Date()
                            let endDate = Calendar.current.date(byAdding: .minute, value: 12, to: startDate)!
                            let dateRange = startDate...endDate
                            
                            Text(timerInterval: dateRange, countsDown: true)
                                .multilineTextAlignment(.center)
                                .frame(width: 50)
                                .monospacedDigit()
                                .font(.system(size: 17))
                        }

                        // Score
                        Text("\(context.state.teamTwoScore)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.leading, 50)
                            .padding(.trailing, 5)
                            .foregroundColor(Color(red: 16/255, green: 57/255, blue: 71/255))
                        
                        
                        // Right team's logo
                        Image("thunder-logo")
                            .resizable()
                            .frame(width: 65, height: 55)
                            .padding(.trailing, 10)
                    }
                    .frame(height: 100)
                }
                
                HStack {
                    // Left team's logo
                    Image("null")
                        .resizable()
                        .frame(width: 50, height: 40)
                    
                    // Middle VStack containing game name and game information
                    VStack {
                        // Game name
                        Text(context.attributes.gameName)
                            .font(.headline)
                            .foregroundColor(Color.white)
                        
                        // Game information
                        Text(context.attributes.gameNumber)
                            .font(.subheadline)
                            .foregroundColor(Color.white.opacity(0.5))
                            .padding(.bottom, 10)
                    }
                    
                    // Right team's logo
                    Image("null")
                        .resizable()
                        .frame(width: 50, height: 40)
                }
                .onTapGesture {
                    print("Live Activity Widget tapped!")
                }
            }
            
            .activityBackgroundTint(Color(red: 38/255, green: 140/255, blue: 173/255))
            .activitySystemActionForegroundColor(Color.black)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Celtics")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Thunder")
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        // Timer
                        let startDate = Date()
                        let endDate = Calendar.current.date(byAdding: .minute, value: 12, to: startDate)!
                        let dateRange = startDate...endDate
                        
                        Text(timerInterval: dateRange, countsDown: true)
                            .multilineTextAlignment(.center)
                            .frame(width: 50)
                            .monospacedDigit()
                        
                        Spacer()
                    }
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Text("\(context.state.teamOneScore) - \(context.state.teamTwoScore)")
                }
            } compactLeading: {
                Text("BOS \(context.state.teamOneScore)")
            } compactTrailing: {
                Text("OKC \(context.state.teamTwoScore)")
            } minimal: {
                Text("\(context.state.teamOneScore) - \(context.state.teamTwoScore)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

