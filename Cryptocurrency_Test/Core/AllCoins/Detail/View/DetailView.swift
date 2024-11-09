//
//  DetailView.swift
//  Cryptocurrency_Test
//
//  Created by Ashish Viltoriya on 04/11/24.
//


import SwiftUI
import Kingfisher

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [ GridItem(.flexible()),
        GridItem(.flexible()),]
    private let spacing: CGFloat = 30
    init(coin: Coin) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
 
    var GraphStatic = ["  1D  ","1W","1M","1Y","5Y","ALL"]
    var body: some View {
        ScrollView {
            
            VStack {
                CustomTapView(imageName: viewModel.coin.image, curentPrice: viewModel.coin.currentPrice, percentageChange: viewModel.coin.priceChangePercentage24H ?? 0.00, percentageChangeDay: viewModel.coin.athChangePercentage ?? 0.00)
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                
                ScrollView (.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(GraphStatic, id: \.self){ data in
                            if data == "  1D  " {
                                Text(data)
                                .font(.custom(FontUtils.MAIN_REGULAR, size: 12))
                                .background(.orange)
                                .foregroundColor(Color.accent)
                            }else {
                                Text(data)
                                    .font(.custom(FontUtils.MAIN_REGULAR, size: 12))
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    }
                }
               
                AccountValue(accuntValueSymbol: "\(viewModel.coin.high24H ?? 0.00) \(viewModel.coin.symbol.uppercased())", accountPercentage: viewModel.coin.altChangePercentage ?? 0.00)
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        VStack (alignment:.leading){
                            Text("LATEST ACTIVITIES")
                                .font(.custom(FontUtils.MAIN_BOLD, size: 15))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        .padding(.horizontal, 15)
                    }
                }
                .padding()
                latestActivitiesView(VModel: viewModel)
                receivedActivitiesView(VModel: viewModel)
            }
           
            //.toolbar(.hidden, for: .tabBar)
           // .toolbarBackground(.hidden, for: .tabBar)
        }
       
        ZStack{
            HStack{
                ForEach((DetailViewTab.allCases), id: \.self){ item in
                    Button{
                        
                    } label: {
                        CustomTabItem(imageName: item.iconName, isActive: true)
                    }
                }
            }
            .padding(6)
        }
        .frame(height: 70)
        .background(.gray.opacity(0.2))
        .cornerRadius(35)
        .padding(.horizontal, 26)
        .navigationTitle(viewModel.coin.name)
    }
}
//
#Preview {
    DetailView(coin: .init(id: "bitcoin",
                           symbol: "BTC",
                           name: "Bitcoin",
                           image: URL(string: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png")!,
                           currentPrice: 45000.0,
                           marketCap: 850_000_000_000.0,
                           marketCapRank: 1,
                           fullyDilutedValuation: 900_000_000_000.0,
                           totalVolume: 30_000_000_000.0,
                           high24H: 46000.0,
                           low24H: 44000.0,
                           priceChange24H: -500.0,
                           priceChangePercentage24H: -1.1,
                           marketCapChange24H: -10_000_000_000.0,
                           marketCapChangePercentage24H: -1.0,
                           circulatingSupply: 18_700_000.0,
                           totalSupply: 21_000_000.0,
                           maxSupply: 21_000_000.0,
                           ath: 65000.0,
                           athChangePercentage: -30.0,
                           athDate: "2021-04-14",
                           alt: 30000.0,
                           altChangePercentage: -10.0,
                           altDate: "2021-05-10",
                           lastUpdated: "2021-10-01T18:30:00Z",
                           sparklineIn7D:.init(price: [43000, 44000, 45000, 46000, 45000, 44000, 43000]),
                           priceChangePercentage24InCurrency: -1.1,
                           currentHoldings: 2.0))
   // }
}
enum DetailViewTab: Int, CaseIterable{
    case home
    case Updated
    case setting
    var iconName: String{
        switch self {
        case .home:
            return "arrow.up"
        case .Updated:
            return "arrow.down"
        case .setting:
            return "arrow.left"
        }
    }
}
extension DetailView{
     public func CustomTabItem(imageName: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 30, height: 30)
            Spacer()
        }
        .frame(width: 70, height: 70)
        .background(isActive ? .gray.opacity(0.4) : .clear)
        .cornerRadius(40)
    }
}

///MARK TOP VIEW ///
///
extension DetailView{
    public func CustomTapView (imageName: URL, curentPrice: Double, percentageChange: Double, percentageChangeDay: Double)-> some View{
            HStack(spacing: 10) {
                
                VStack (alignment:.leading){
                    Text("$\(curentPrice.asCurrencyWith6Decimals())")
                        .font(.custom(FontUtils.MAIN_BOLD, size: 30))
                        .foregroundColor(.black)
                    HStack {
                        Image(systemName: "triangle.fill")
                            .font(.caption2)
                            .rotationEffect(Angle(degrees: (percentageChange) >= 0 ? 0 : 180 ))
                        Text("\(percentageChange.asCurrencyWith6Decimals())%")
                            .font(.caption)
                            .bold()
                        VStack{
                            Text("+$\(percentageChangeDay.asCurrencyWith6Decimals())")
                                .font(.caption)
                                .bold()
                        }
                        VStack{
                            Text("Today")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.gray)
                        }
                    }
                    .foregroundColor(.green)
                    
                }
                .padding(.horizontal, 10)
                Spacer()
                KFImage(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.horizontal, 20)
            }
        }
    
    public func AccountValue (accuntValueSymbol: String, accountPercentage: Double) -> some View {
        HStack(spacing: 10) {
            
            VStack (alignment:.leading){
                Text("Account Value")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.vertical, 10)
                Text(accuntValueSymbol)
                    .font(.custom(FontUtils.MAIN_BOLD, size: 30))
                Text("$\(accountPercentage.asCurrencyWith6Decimals())")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15)
            Spacer()
    
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 130)
        .background(.white)
        .cornerRadius(15, corners: .allCorners)
        .shadow(radius: 10)
        .padding(.horizontal, 15)
        
    }
    
    public func latestActivitiesView (VModel: DetailViewModel) -> some View {
        HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 6) {
                Text("Send")
                .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                .foregroundColor(.black)
                .padding(.bottom, 5)
                    //let today = Date().formatDate()
                    
                Text(VModel.coin.athDate ?? "")
                .font(.custom(FontUtils.MAIN_REGULAR, size: 12))
                .foregroundColor(.gray)
            }
            .padding()
            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Text("\(VModel.coin.currentPrice.asCurrencyWith6Decimals()) \(VModel.coin.symbol.uppercased())")
                .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                .foregroundColor(.black)
                .padding(.bottom, 5)

                Text("$\(VModel.coin.athChangePercentage!.asCurrencyWith6Decimals())")
                .font(.custom(FontUtils.MAIN_REGULAR, size: 12))
                .foregroundColor(.gray)
        }.padding()

    }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 90)
        .background(.white)
        .cornerRadius(10, corners: .allCorners)
        .shadow(radius: 10)
        .padding(.horizontal, 15)

    
    }
    public func receivedActivitiesView (VModel: DetailViewModel) -> some View {
        HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 6) {
                Text("Received")
                .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                .foregroundColor(.black)
                .padding(.bottom, 5)

                Text(VModel.coin.athDate ?? "")
                .font(.custom(FontUtils.MAIN_REGULAR, size: 12))
                .foregroundColor(.gray)
            }
            .padding()
            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Text("\(VModel.coin.currentPrice.asCurrencyWith6Decimals()) \(VModel.coin.symbol.uppercased())")
                .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                .foregroundColor(.black)
                .padding(.bottom, 5)

                Text("$\(VModel.coin.athChangePercentage!.asCurrencyWith6Decimals())")
                .font(.custom(FontUtils.MAIN_REGULAR, size: 12))
                .foregroundColor(.gray)
        }.padding()

    }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 90)
        .background(.white)
        .cornerRadius(10, corners: .allCorners)
        .shadow(radius: 10)
        .padding(.horizontal, 15)

    }
}
