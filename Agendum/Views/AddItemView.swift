//
//  AddItemView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import Firebase

struct AddItemView: View {
    @State private var title: String = ""
    @State private var task = false
    @State private var habit = false
    @State private var date = false
    @State private var reminder = false
    @State private var calendar = false
    @State private var completed = false
    @State private var showingAlert = false
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        
        VStack{
            
            ZStack(alignment: .leading){
                
                Button(action: {
                    self.viewRouter.viewRouter = "Dashboard"
                }) {
                    Image(uiImage: UIImage(named: "Icons/Back - black.png")!)
                        .renderingMode(.original)
                }.padding(.bottom)
                
                TextWithBottomBorder(text: "A d d  I t e m")
            }

            TextFieldWithBottomBorder(placeholder: "Title", text: $title)
            
            Toggle(isOn: $task) {
                                   
                Text("T a s k")
                    .font(Font.custom("Montserrat-Regular", size: 15))
                
            }.padding()
            
            Toggle(isOn: $habit) {
                                   
                Text("H a b i t")
                    .font(Font.custom("Montserrat-Regular", size: 15))
                
            }.padding()
            
            Toggle(isOn: $date) {
                                   
                Text("D a t e")
                    .font(Font.custom("Montserrat-Regular", size: 15))
                
            }.padding()
            
            Toggle(isOn: $reminder) {
                                   
                Text("S e t  a  r e m i n d e r")
                    .font(Font.custom("Montserrat-Regular", size: 15))
                
            }.padding()
            
            Toggle(isOn: $calendar) {
                                   
                Text("A d d  t o  c a l e n d a r")
                    .font(Font.custom("Montserrat-Regular", size: 15))
                
            }.padding()
            
            Text("L a b e l s")
                .font(Font.custom("Montserrat-Regular", size: 15))
                .padding()
            
            List {
                Text("Label 1")
                Text("Label 2")
                Text("Label 3")
            }
            
            ButtonOne(text: "A D D", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                
                if (self.title != "") {
                    
                    self.session.loggedInUser?.items.append(Item(title: self.title, task: self.task, habit: self.habit, dateToggle: self.date, reminderToggle: self.reminder, completed: self.completed))
                    self.session.saveItems(items: self.session.loggedInUser?.items ?? [])
                    self.viewRouter.viewRouter = "Dashboard"
                    
                } else {
                    
                    self.showingAlert = true
                }
            }).alert(isPresented: $showingAlert) {
                
                Alert(title: Text("Please add a title!"), dismissButton: .default(Text("Got it!")))
            }
            
        }.padding()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(viewRouter: ViewRouter())
    }
}
