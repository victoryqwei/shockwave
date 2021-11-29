import SwiftUI

func timeConvert(secs: Int) -> String {
    let hours =  (secs - (secs % 3600)) / 3600
    let minutes = (secs - (hours * 3600) - ((secs - (hours * 3600)) % 60)) / 60
    let seconds = secs - (hours * 3600) - (minutes * 60)
    
    let secondsString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
    let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
    
    return "\(hours):\(minutesString):\(secondsString)"
}

extension View{
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
}

struct MainView: View {
    @Binding var phonePickupCounter: Int
    @Binding var currentState: Bool
    @Binding var currentMode: Bool
    @Binding var shockLevel: Double
    @Binding var vibrateLevel: Double
    
    @State var sessionText: String = "Start New Session"
    @State var goalText: String = "No Current Goal Set"
    
    @State var sessionStarted = false
    @State var sessionFinished = false
    @State var showTimeSelect = false
    @State var showSettingsSheet = false
    @State var showShopSheet = false
    
    @State var timeRemaining = 0
    @State var credits = 0
    @State var hourInput = 0
    @State var minuteInput = 0
    @State var quitCount = 0
    
    @State var animationOpacity: Double = 0
    
    @State var totalTimeSpent = 0
    
    @State var theme1Purchased = false
    @State var theme2Purchased = false
    @State var theme3Purchased = false
    
    @State var theme1PurchaseString = "Purchase"
    @State var theme2PurchaseString = "Purchase"
    @State var theme3PurchaseString = "Purchase"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(goalText).padding()
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                Text("You have picked up the phone \(phonePickupCounter) times").font(.subheadline).padding([.leading, .bottom])
                Text("You have successfully spent \(timeConvert(secs: totalTimeSpent)) away")
                    .font(.subheadline)
                    .padding(.leading)
                HStack {
                    Spacer()
                    Text("Credits Earned: \(credits)")
                        .font(.caption)
                        .padding()
                }
            }.padding(.top)
            
            Spacer()
            
            ZStack {
                Button {
                } label: {
                    Text(sessionText)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).stroke())
                        .padding()

                }.buttonStyle(PlainButtonStyle())
                    .simultaneousGesture(LongPressGesture().onEnded { _ in
                        if (quitCount == 1) {
                            sessionText = "Start New Session"
                            sessionFinished = false
                            sessionStarted = false
                            timeRemaining = -1
                            quitCount = 0
                        }
                    })
                    .simultaneousGesture(TapGesture().onEnded {
                        if (!sessionFinished && !sessionStarted) {
                            showTimeSelect.toggle()
                            withAnimation {
                                animationOpacity += 1
                            }
                        }
    
                        if (sessionStarted) {
                            switch (quitCount) {
                                case 0:
                                    sessionText = "Quit Activated: Hold to Quit"
                                    quitCount = 1
                                default:
                                    sessionText = "Current Session"
                                    quitCount = 0
                            }
                        }
                        
                        if (sessionFinished) {
                            credits += hourInput * 360 + minuteInput * 6
                            totalTimeSpent += hourInput * 3600 + minuteInput * 60
                            sessionFinished = false
                            sessionStarted = false
                            quitCount = 0
                            timeRemaining = -1
                            sessionText  = "Start New Session"
                        }
                    })
                
                if (showTimeSelect) {
                    VStack {
                        HStack(spacing: 15) {
                            Text("Select Session Time")
                                .foregroundColor(.blue)
                        }
                        .padding(.top)
                        .foregroundColor(.black)

                        Divider()
                        
                        HStack() {
                            Spacer()
                            Text("Hours")
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            Spacer()
                            
                            Text("Minutes")
                                .foregroundColor(Color.black)
                            Spacer()
                        }.padding(.top)
                        
                        GeometryReader { geometry in
                            HStack (spacing: 0) {
                                Picker("hours", selection: $hourInput) {
                                    ForEach(0...99, id: \.self) {
                                        Text("\($0)")
                                            .foregroundColor(.black)
                                            .font(.body)
                                    }
                                }
                                .frame(width: geometry.size.width/2, height: geometry.size.height - 100, alignment: .center)
                                .pickerStyle(.wheel)
                                .compositingGroup()
                                .clipped()
                                
                                Picker("minutes", selection: $minuteInput) {
                                    ForEach(0...59, id: \.self) {
                                        Text("\($0)")
                                            .foregroundColor(.black)
                                            .font(.body)
                                    }
                                }
                                .frame(width: geometry.size.width/2, height: geometry.size.height - 100, alignment: .center)
                                .pickerStyle(.wheel)
                                .compositingGroup()
                                .clipped()
                            }.frame(height: geometry.size.height - 50)
                        }
                            .padding(.top)
                        HStack {
                            Button {
                                showTimeSelect.toggle()
                                withAnimation {
                                    animationOpacity -= 1
                                }
                            } label: {
                                Text("Cancel")
                                    .padding( [.bottom, .trailing] )
                                    .foregroundColor(.red)
                            }
                            
                            Button {
                                showTimeSelect.toggle()
                                sessionStarted = true
                                sessionText = "Current Session"
                                goalText = "Current Goal: \(timeConvert(secs: (hourInput * 3600 + minuteInput * 60)))"
                                timeRemaining = hourInput * 3600 + minuteInput * 60
                               
                                withAnimation {
                                    animationOpacity -= 1
                                }
                            } label: {
                                Text("Start Session")
                                    .padding( [.bottom, .leading] )
                            }
                        }
                    }
                    .frame(width: getWidth() - 120)
                    .background(Color.primary)
                    .cornerRadius(10)
                    .opacity(animationOpacity)
                }
            }
            
            if (sessionStarted) {
                Text(timeConvert(secs: timeRemaining))
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else if timeRemaining == 0 {
                            sessionFinished = true
                            sessionText = "Session Finished: Click for Credits!"
                        }
                    }
            }
            Spacer()
            
            Text(!currentState ? "Enable Collar in Settings" : currentMode ? "Shock Level" : "Vibration Level")
            if currentMode {
                Slider(value: $shockLevel, in: 1...8, step: 1) // Change step by how many levels of shock we have
                    .padding([.leading, .bottom, .trailing])
                    .opacity(currentState ? 1 : 0.25)
                    .disabled(!currentState)
            } else {
                Slider(value: $vibrateLevel, in: 1...8, step: 1) // Change step by how many levels of shock we have
                    .padding([.leading, .bottom, .trailing])
                    .opacity(currentState ? 1 : 0.25)
                    .disabled(!currentState)
            }
            HStack {
                Button {
                    showSettingsSheet.toggle()
                } label: {
                    Text("Settings")
                        .padding( [.leading, .bottom] )
                }.fullScreenCover(isPresented: $showSettingsSheet) {
                    SettingsView(currentState: $currentState, currentMode: $currentMode, theme1Purchased: $theme1Purchased, theme2Purchased: $theme2Purchased, theme3Purchased: $theme3Purchased)
                }
                
                Spacer()
                
                Button {
                    showShopSheet.toggle()
                } label: {
                    Text("Store")
                        .padding( [.bottom, .trailing] )
                }.fullScreenCover(isPresented: $showShopSheet) { // Don't look at this part
                    ShopView(credits: $credits, theme1Purchased: $theme1Purchased, theme2Purchased: $theme2Purchased, theme3Purchased: $theme3Purchased, theme1PurchaseString: $theme1PurchaseString, theme2PurchaseString: $theme2PurchaseString, theme3PurchaseString: $theme3PurchaseString)
                }
            }
        }
    }
}
