//
//  LandingView.swift
//  CITRARB
//
//  Created by Richard Uzor on 18/07/2023.
//

import SwiftUI

struct LandingView: View {
    
    @State private var isPresentingNewScreen = false
    
    
    var body: some View {
        NavigationView{
          
            ZStack{
                Image("bgDay")
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.5)
                
                VStack{
                    
                    HStack{
                            VStack{
                                Text("MCM")
                                    .bold()
                                Image(systemName: "person.circle.fill")
                                    .font(.largeTitle)
                                    .aspectRatio(contentMode: .fill)
                                Text("John Doe")
                            }
                            .frame(width: 120)
                    
                       
//                        .onTapGesture {
//                            
//                        }
                        VStack{
                            Text("WCW")
                                .bold()
                            Image(systemName: "person.circle.fill")
                                .font(.largeTitle)
                            
                                .aspectRatio(contentMode: .fill)
                            Text("Jane Doe")
                        }
                        .frame(width: 120)
                        .onTapGesture {
                            
                        }
                        
                    }
                    .padding()
                    
                    HStack{
                        ZStack{
                            MenuItemView(animation: "citrarb_news_menu")
                            Text("News")
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .font(.system(size: 18))
                                .padding(8)
                        }
                        .background(NEWS_COLOR)
                        .cornerRadius(30)
                        .shadow(color: NEWS_COLOR,radius: 5)
                        
                        NavigationLink(destination: TVListView()){
                            ZStack{
                                MenuItemView(animation: "citrarb_tv_menu")
                                Text("TV")
                                    .bold()
                                    .foregroundColor(.white)
                                    .offset(y: 50)
                                    .font(.system(size: 18))
                                    .padding(8)
                            }
                            .background(TV_COLOR)
                            .cornerRadius(30)
                            .shadow(color: TV_COLOR,radius: 5)
                            
                        }
                        
                        
                        
                        ZStack{
                            MenuItemView(animation: "citrarb_eye_witness_menu")
                            Text("Eye Witness")
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .font(.system(size: 18))
                                .padding(8)
                        }
                        .background(EYE_WITNESS_COLOR)
                        .cornerRadius(30)
                        .shadow(color: EYE_WITNESS_COLOR,radius: 5)
                        
                    }
                    .padding()
                    
                    HStack{
                        ZStack{
                            MenuItemView(animation: "citrarb_members_menu")
                            Text("Members")
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .font(.system(size: 18))
                                .padding(8)
                        }
                        .background(MEMBERS_COLOR)
                        .cornerRadius(30)
                        .shadow(color: MEMBERS_COLOR,radius: 5)
                        ZStack{
                            MenuItemView(animation: "citrarb_market_place_menu")
                            Text("Marketplace")
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .font(.system(size: 17))
                                .padding(8)
                        }
                        .background(MARKET_PLACE_COLOR)
                        .cornerRadius(30)
                        .shadow(color: MARKET_PLACE_COLOR,radius: 5)
                        ZStack{
                            MenuItemView(animation: "citrarb_events_menu")
                            Text("Events")
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .font(.system(size: 18))
                                .padding(8)
                        }
                        .background(EVENTS_COLOR)
                        .cornerRadius(30)
                        .shadow(color: EVENTS_COLOR,radius: 5)
                        
                    }
                    .padding()
                    
                    HStack{
                        ZStack{
                            MenuItemView(animation: "citrarb_connect_menu")
                            Text("Connect")
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .font(.system(size: 18))
                                .padding(8)
                        }
                        .background(CONNECT_COLOR)
                        .cornerRadius(30)
                        .shadow(color: CONNECT_COLOR,radius: 5)
                        ZStack{
                            MenuItemView(animation: "citrarb_music_menu")
                            Text("Music")
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .font(.system(size: 18))
                                .padding(8)
                        }
                        .background(MUSIC_COLOR)
                        .cornerRadius(30)
                        .shadow(color: MUSIC_COLOR,radius: 5)
                        ZStack{
                            MenuItemView(animation: "citrarb_uploads_menu")
                            Text("Uploads")
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: 50)
                                .font(.system(size: 18))
                                .padding(8)
                        }
                        .background(UPLOADS_COLOR)
                        .cornerRadius(30)
                        .shadow(color: UPLOADS_COLOR,radius: 5)
                    }
                }
                .padding(8)
                
            }
        }
        .navigationBarTitle("Title")
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
