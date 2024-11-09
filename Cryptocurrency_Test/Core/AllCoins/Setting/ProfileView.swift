//
//  ProfileView.swift
//  Cryptocurrency_Test
//
//  Created by Ashish Viltoriya on 04/11/24.
//

import SwiftUI

#Preview {
    ProfileView()
}

struct ProfileView: View {

    var body: some View {
        ZStack(alignment: .top){
            VStack(alignment: .center){
                HStack (alignment: .top){
                    Button(action:{
                    }, label: {
                       Image(systemName: "line.3.horizontal")
                            .resizable()
                            .foregroundColor(.black)
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    })
                    .frame(width: 45, height: 45)
                    .background(.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    Spacer()
                    Button(action: {}, label: {
                        Image("preeti")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    })
                    .frame(width: 75, height: 75)
                    .background(.white)
                    .cornerRadius(50)
                    .shadow(radius: 10)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "bell")
                            .resizable()
                            .foregroundColor(.black)
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    })
                    .frame(width: 45, height: 45)
                    .background(.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)

                }
                .padding(30)
            }
        }
    }
}

