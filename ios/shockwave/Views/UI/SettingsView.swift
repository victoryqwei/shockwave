import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var themeDefault = true
    @State var theme1 = false
    @State var theme2 = false
    @State var theme3 = false
    
    @Binding var currentState: Bool
    @Binding var currentMode: Bool
    
    @Binding var theme1Purchased: Bool
    @Binding var theme2Purchased: Bool
    @Binding var theme3Purchased: Bool
    
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
                            themeDefault = true
                            theme1 = false
                            theme2 = false
                            theme3 = false
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
                            themeDefault = false
                            theme1 = true
                            theme2 = false
                            theme3 = false
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
                            themeDefault = false
                            theme1 = false
                            theme2 = true
                            theme3 = false
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
                            themeDefault = false
                            theme1 = false
                            theme2 = false
                            theme3 = true
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
