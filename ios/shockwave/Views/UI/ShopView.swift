import SwiftUI

struct ShopView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var credits: Int
    @Binding var theme1Purchased: Bool
    @Binding var theme2Purchased: Bool
    @Binding var theme3Purchased: Bool
    
    @Binding var theme1PurchaseString: String
    @Binding var theme2PurchaseString: String
    @Binding var theme3PurchaseString: String
    
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
                        theme1Purchased = true
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
                        theme2Purchased = true
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
                        theme3Purchased = true
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
