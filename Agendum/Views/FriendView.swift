//
//  FriendView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct FriendView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
                    
        NavigationView {
                        
            ZStack {
                            
                VStack (alignment: .leading) {
                                
                    TextWithBottomBorder(text: "F r i e n d s")
                        
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            ForEach(0..<(session.loggedInUser?.following.count)!) { i in
                                
                                NavigationLink(destination: FriendDetailView(email: session.loggedInUser!.following[i], progress: session.loggedInUser!.followingProgress[i])) {
                                    
                                    Text("\((session.loggedInUser?.following[i])!)")
                                        .padding()
                                }
                            }
                        }
                        .frame(width: (UIScreen.main.bounds.width) / 2)
                        
                        VStack {
                            
                            ForEach(session.loggedInUser?.followingProgress ?? [], id:\.self) { progress in
                                
                                Text("\(Int(progress))")
                                    .padding()
                            }
                        }
                        .frame(width: (UIScreen.main.bounds.width) / 2, alignment: .trailing)
                    }
                                
                    Spacer()
                                
                    HorizontalLineShape
                        .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
                        .padding(.horizontal)
                                
                    HStack {
                                    
                        Text("Y o u")
                            .font(Font.custom("Montserrat-Regular", size: 15))
                                    
                        Spacer()
                                    
                        Text("\(Int(session.loggedInUser!.progress))")
                            .font(Font.custom("Montserrat-Regular", size: 15))
                                    
                    }.padding()
                }
                            
                FloatingAddButton(action: {
                    
                    self.viewRouter.viewRouter = "Add Friend"
                })
                .frame(height: 550)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}
