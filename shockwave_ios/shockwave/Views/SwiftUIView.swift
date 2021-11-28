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

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var themeDefault = true;
    @State var theme1 = false;
    @State var theme2 = false;
    @State var theme3 = false;
    
    @Binding var currentState: Bool;
    @Binding var currentMode: Bool;
    
    @Binding var theme1Purchased: Bool;
    @Binding var theme2Purchased: Bool;
    @Binding var theme3Purchased: Bool;
    
    var body: some View {
        VStack {
            Text("Settings")
                .padding()
            
            Divider()
            
            HStack{
                VStack (alignment: .leading) {
                    HStack {
                        Text("Shock / Vibrate Mode")
                            .font(.subheadline)
                            .padding( [.top, .leading] )
                        Spacer()
                        Toggle("", isOn: $currentMode).padding(.top)
                    }
                    
                    HStack {
                        Text("Current: \(currentMode ? "Shock" : "Vibration")")
                            .font(.caption)
                            .padding( .leading )
                    }
                    .padding(.top, 0.01)
                    .padding(.leading, 20)
                    
                    
                    HStack {
                        Text("Shock / Vibrate On")
                            .font(.subheadline)
                            .padding( [.top, .leading] )
                        Spacer()
                        Toggle("", isOn: $currentState).padding(.top)
                    }
                    
                }
                Spacer()
                
                
            }
            
            Spacer()
            
            Text("Change Colour Scheme").padding()
            
            Divider()
            
            HStack {
                VStack (alignment: .leading) {
                    HStack {
                        Text("Default Theme")
                            .padding( [.top, .leading] )
                        Spacer()
                        Button {
                            themeDefault = true;
                            theme1 = false;
                            theme2 = false;
                            theme3 = false;
                        } label: {
                            Text(themeDefault ? "Selected" : "Use")
                                .font(.caption)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke())
                                .foregroundColor(themeDefault ? .blue : .green)
                        }
                             .padding(.top)
                             .disabled(themeDefault)
                    }
                    HStack {
                        Text("Blue Theme")
                            .padding( [.top, .leading] )
                        Spacer()
                        Button {
                            themeDefault = false;
                            theme1 = true;
                            theme2 = false;
                            theme3 = false;
                        } label: {
                            Text(theme1 ? "Selected" : !theme1Purchased ? "Buy in Store": "Use")
                                .font(.caption)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke())
                                .foregroundColor((!theme1Purchased ? .gray : theme1 ? .blue : .green))
                        }
                             .padding(.top)
                             .disabled(!theme1Purchased || theme1)
                    }
                    HStack {
                        Text("Green Theme")
                            .padding( [.top, .leading] )
                        Spacer()
                        Button {
                            themeDefault = false;
                            theme1 = false;
                            theme2 = true;
                            theme3 = false;
                        } label: {
                            Text(theme2 ? "Selected" : !theme2Purchased ? "Buy in Store": "Use")
                                .font(.caption)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke())
                                .foregroundColor(!theme2Purchased ? .gray : theme2 ? .blue : .green)
                        }
                             .padding(.top)
                             .disabled(!theme2Purchased || theme2)
                    }
                    HStack {
                        Text("Orange Theme")
                            .padding( [.top, .leading] )
                        Spacer()
                        Button {
                            themeDefault = false;
                            theme1 = false;
                            theme2 = false;
                            theme3 = true;
                        } label: {
                            Text(theme3 ? "Selected" : !theme3Purchased ? "Buy in Store": "Use")
                                .font(.caption)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 10).stroke())
                                .foregroundColor((!theme3Purchased ? .gray : theme3 ? .blue : .green))
                        }
                             .padding(.top)
                             .disabled(!theme3Purchased || theme3)
                    }
                }
                Spacer()
            }
            
            Spacer()
            
            Button("Back") {
                dismiss()
            }.foregroundColor(.blue)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .foregroundColor(.white)
    }
}

struct ShopView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var credits: Int
    @Binding var theme1Purchased: Bool;
    @Binding var theme2Purchased: Bool;
    @Binding var theme3Purchased: Bool;
    
    @Binding var theme1PurchaseString: String;
    @Binding var theme2PurchaseString: String;
    @Binding var theme3PurchaseString: String;
    
    var body: some View {
        VStack {
            Text("Shop")
                .padding()
            
            Divider()
            
            HStack{
                VStack (alignment: .leading) {
                    Text("Credits: \(credits)")
                        .font(.subheadline)
                        .padding()
                }
                Spacer()
            }
            Spacer()
            
            VStack{
                Text("Blue (1000 Credits)")
                    .padding(.top)
                Divider()
                Spacer()
                Image("Blue")
                    .resizable()
                    .frame(width: 100, height: 100)
                Button {
                    if (credits >= 1000) {
                        theme1PurchaseString = "Purchased!"
                        theme1Purchased = true;
                        credits -= 1000
                    } else {
                        theme1PurchaseString = "Not Enough Credits!"
                    }
                } label: {
                    Text(theme1PurchaseString)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).stroke())
                        .foregroundColor(theme1Purchased ? .gray : .green)
                }.disabled(theme1Purchased)
            }
            
            VStack{
                Text("Green (2000 Credits)")
                    .padding(.top)
                Divider()
                Spacer()
                Image("Green")
                    .resizable()
                    .frame(width: 100, height: 100)
                    
                Button {
                    if (credits >= 2000) {
                        theme2PurchaseString = "Purchased!"
                        theme2Purchased = true;
                        credits -= 2000
                    } else {
                        theme2PurchaseString = "Not Enough Credits!"
                    }
                } label: {
                    Text(theme2PurchaseString)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).stroke())
                        .foregroundColor(theme2Purchased ? .gray : .green)
                }
            }.disabled(theme2Purchased)
            
            VStack{
                Text("Orange (3000 Credits)")
                    .padding(.top)
                Divider()
                Spacer()
                Image("Orange")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Button {
                    if (credits >= 3000) {
                        theme3PurchaseString = "Purchased!"
                        theme3Purchased = true;
                        credits -= 3000
                    } else {
                        theme3PurchaseString = "Not Enough Credits!"
                    }
                } label: {
                    Text(theme3PurchaseString)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).stroke())
                        .foregroundColor(theme3Purchased ? .gray : .green)
                }.disabled(theme3Purchased)
            }
            
            Spacer()
            
            Button("Back") {
                if (!theme1Purchased) {
                    theme1PurchaseString = "Purchase"
                }
                
                if (!theme2Purchased) {
                    theme2PurchaseString = "Purchase"
                }
                
                if (!theme3Purchased) {
                    theme3PurchaseString = "Purchase"
                }
                
                dismiss()
            }
            .foregroundColor(.blue)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .foregroundColor(.white)
    }
}

struct SwiftUIView: View {
    @State var sessionText: String = "Start New Session"
    @State var goalText: String = "No Current Goal Set"
    
    @State var sessionStarted = false
    @State var sessionFinished = false
    @State var showTimeSelect = false
    @State var showSettingsSheet = false;
    @State var showShopSheet = false;
    
    @State var timeRemaining = 0
    @State var credits = 0
    @State var hourInput = 0
    @State var minuteInput = 0
    @State var quitCount = 0
    
    @State var shockLevel: Double = 50;
    @State var animationOpacity: Double = 0;
    
    @State var phonePickupCounter = 0;
    @State var totalTimeSpent = 0;
    
    @State var theme1Purchased = false;
    @State var theme2Purchased = false;
    @State var theme3Purchased = false;
    
    @State var theme1PurchaseString = "Purchase";
    @State var theme2PurchaseString = "Purchase";
    @State var theme3PurchaseString = "Purchase";
    
    @State var currentState = true;
    @State var currentMode = true;
    
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
                            sessionFinished = false;
                            sessionStarted = false;
                            timeRemaining = -1
                            quitCount = 0;
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
                            sessionFinished = false;
                            sessionStarted = false;
                            quitCount = 0;
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
                                showTimeSelect.toggle();
                                withAnimation {
                                    animationOpacity -= 1
                                }
                            } label: {
                                Text("Cancel")
                                    .padding( [.bottom, .trailing] )
                                    .foregroundColor(.red)
                            }
                            
                            Button {
                                showTimeSelect.toggle();
                                sessionStarted = true;
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
                            sessionFinished = true;
                            sessionText = "Session Finished: Click for Credits!"
                        }
                    }
            }
            Spacer()
            
            Text(!currentState ? "Enable Collar in Settings" : currentMode ? "Shock Level" : "Vibration Level")
            Slider(value: $shockLevel, in: 0...100, step: 25) // Change step by how many levels of shock we have
                .padding([.leading, .bottom, .trailing])
                .opacity(currentState ? 1 : 0.25)
                .disabled(!currentState);
            
            HStack {
                Button {
                    showSettingsSheet.toggle();
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
