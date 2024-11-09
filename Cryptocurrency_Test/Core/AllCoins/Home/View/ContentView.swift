//
//  ContentView.swift
//  Cryptocurrency_Test
//
//  Created by Ashish Viltoriya on 03/11/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                HomeTopView()
                SendAndReceiveView()
                List {
                    ForEach(viewModel.coins) { coin in
                        NavigationLink (
                            destination: DetailView(coin: coin)
                                
                            ,
                            label: {
                                HStack(spacing: 10) {
                                    KFImage(coin.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(coin.name)
                                            .fontWeight(.semibold)
                                            .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                                            .foregroundColor(.black)
                                        Text("$\(coin.currentPrice.asCurrencyWith6Decimals())")
                                            .font(.custom(FontUtils.MAIN_REGULAR, size: 12))
                                            .foregroundColor(.gray)
                                        
                                    }
                                    Spacer()
                                    MiniChartView(coin: coin)
                                        .frame(width: 60, height: 40)
                                    Spacer()
                                    
                                    VStack(alignment: .trailing) {
                                        
                                        Text("\(coin.priceChange24H?.withoutPercentString() ?? "")  \(coin.symbol.uppercased())")
                                            .font(.custom(FontUtils.MAIN_REGULAR, size: 12))
                                            .foregroundColor(.black)
                                        Text("\(coin.priceChangePercentage24H?.asPercentString() ?? "")")
                                            .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
                                    }
                                }
                                .font(.footnote)
                            }).tint(Color.theme.secondaryText)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle(Text(""))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "plus.circle")
                }
            }
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
        
    }
    
}



///MARK TOP VIEW ///
struct HomeTopView: View {
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    VStack (alignment:.leading){
                        Text("Crypto")
                            .font(.custom(FontUtils.MAIN_BOLD, size: 30))
                            .foregroundColor(.black)
                        
                        Text("Account value")
                            .font(.custom(FontUtils.MAIN_REGULAR, size: 16))
                            .foregroundColor(.gray)
                            .frame(maxWidth: 160)
                            .lineLimit(1)
                            .padding(.top, 10)
                            .padding(.leading, -20)
                        
                        Text("$11,542.21")
                            .font(.custom(FontUtils.MAIN_BOLD, size: 30))
                            .foregroundColor(.black)
                        
                    }
                    .padding(.leading, 0)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

///MARK Send And Receive VIEW ///
struct SendAndReceiveView: View {
    var sampleList : [Lists] = [.init(image: "arrow.up", name: "Send"),.init(image: "arrow.down", name: "Receive")]
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                ForEach(sampleList){ value in
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: value.image)
                                .foregroundStyle(.white)
                            Text(value.name)
                                .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                                .foregroundStyle(.white)
                        }
                        .padding(4)
                    })
                    .padding(6)
                    .background(.black)
                    .cornerRadius(20, corners: .allCorners)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
