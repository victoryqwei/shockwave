import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Current Goal: 10:00 ").padding()
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                Text("You have picked up the phone {x} times").font(.subheadline).padding([.leading, .bottom])
                Text("You have successfully spent {time} away")
                    .font(.subheadline)
                    .padding(.leading)
                HStack {
                    Spacer()
                    Text("Credits Earned: 1337").font(.caption).padding()
                }
            }.padding(.top)
            
            Spacer()
            Text("Current Session").padding().background(RoundedRectangle(cornerRadius: 15).stroke()).padding()
            Text("00:00:54")
            Spacer()
            
            Text("Shock Level")
            Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/).padding([.leading, .bottom, .trailing])
            
            HStack {
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Settings").padding([.leading, .bottom])
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Store").padding([.bottom, .trailing])
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
            .preferredColorScheme(.light)
    }
}
