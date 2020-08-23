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
    @State private var taskToggle = false
    @State private var habitToggle = false
    @State private var dateToggle = false
    @State private var eventToggle = false
    @State private var eventDuration = 0
    @State private var date = Date()
    @State private var reminderToggle = false
    @State private var reminder = Date()
    @State private var calendarToggle = false
    @State private var completedToggle = false
    @State private var showingAlert = false
    @State private var newLabel: String = ""
    @State private var addLabel: Bool = false
    @State private var selectedLabels: Array<String> = []
    
    var timeIntervals = ["30 minutes", "1 hour", "1.5 hours", "2 hours"]
    
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var viewRouter: ViewRouter
    
    func convertToInterval(interval: Int) -> TimeInterval? {
        
        var newInterval: TimeInterval?
        let minute: TimeInterval = 60.0
        let hour: TimeInterval = 60.0 * minute
        
        switch interval {
        
            case 0:
                newInterval = minute * 30
            case 1:
                newInterval = hour
            case 2:
                newInterval = hour + (minute * 30)
            case 3:
                newInterval = hour * 2
            default:
                newInterval = nil
        }
        
        return newInterval
    }
    
    var body: some View {
        
        VStack{
            
            //Title
            ZStack(alignment: .leading){
                
                Button(action: {
                    self.viewRouter.viewRouter = "Dashboard"
                }) {
                    Image(uiImage: UIImage(named: "Icons/Back - black.png")!)
                        .renderingMode(.original)
                }.padding(.bottom)
                
                TextWithBottomBorder(text: "A d d  I t e m")
            }
            
            //User Input Fields
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    Group {
                        
                        TextFieldWithBottomBorder(placeholder: "Title", text: $title)
                        
                        Toggle(isOn: $taskToggle) {
                                               
                            Text("T a s k")
                                .font(Font.custom("Montserrat-Regular", size: 15))
                            
                        }.padding()
                        
                        Toggle(isOn: $habitToggle) {
                                               
                            Text("H a b i t")
                                .font(Font.custom("Montserrat-Regular", size: 15))
                            
                        }.padding()
                        
                        Toggle(isOn: $eventToggle) {
                            
                            Text("E v e n t")
                                .font(Font.custom("Montserrat-Regular", size: 15))
                        }.padding()
                        
                        if (eventToggle) {
                            
                            Picker(selection: $eventDuration, label: Text("")) {
                                
                                ForEach(0 ..< timeIntervals.count) {
                                    Text(self.timeIntervals[$0]).tag($0)
                                }
                            }
                        }
                        
                        Toggle(isOn: $dateToggle) {
                                               
                            Text("D a t e")
                                .font(Font.custom("Montserrat-Regular", size: 15))
                            
                        }.padding()
                        
                        if (dateToggle) {
                            
                            DatePicker("", selection: $date, in: Date()...)
                                .frame(minHeight: 50)
                        }
                        
                        Toggle(isOn: $reminderToggle) {
                                               
                            Text("S e t  a  r e m i n d e r")
                                .font(Font.custom("Montserrat-Regular", size: 15))
                            
                        }.padding()
                        
                        if (reminderToggle) {
                            
                            DatePicker("", selection: $reminder, in: Date()...)
                                .frame(minHeight: 50)
                        }
                        
                        Toggle(isOn: $calendarToggle) {
                                               
                            Text("A d d  t o  c a l e n d a r")
                                .font(Font.custom("Montserrat-Regular", size: 15))
                            
                        }.padding()
                    }
                    
                    Group {
                        
                        HStack{
                                
                            Text("L a b e l s")
                                .font(Font.custom("Montserrat-Regular", size: 15))
                                .padding()
                                
                            Button(action:{
                                self.addLabel.toggle()
                                    
                            }){
                                Text("➕")
                            }
                        }

                        if (addLabel) {
                                
                            VStack{
                                    
                                HStack {
                                    TextField("New Label", text: $newLabel)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    Button(action: {
                                        self.session.loggedInUser?.labels.append(self.newLabel)
                                        self.addLabel.toggle()
                                    }){
                                        Text("✔️").padding()
                                    }
                                }
                                        
                                Divider()
                            }
                        }
                            
                        ForEach (session.loggedInUser?.labels ?? [], id: \.self) { label in

                            Text(String(label))
                                .frame(width: UIScreen.main.bounds.width)
                                .onTapGesture {

                                    if (!self.selectedLabels.contains(label)) {
                                
                                        self.selectedLabels.append(label)
                                    
                                    } else if (self.selectedLabels.contains(label)){
                                        
                                        var index = 0
                                    
                                        for currentLabel in self.selectedLabels {
                                            
                                            if (currentLabel == label) {
                                                
                                                self.selectedLabels.remove(at: index)
                                            }
                                            
                                            index += 1
                                        }
                                    }
                                
                            }.background(self.selectedLabels.contains(label) ? Color.init(red: 0.6, green: 0.9, blue: 1.0) : Color.white)
                        }
                    }
                }.frame(width: UIScreen.main.bounds.width)
            }.frame(width: UIScreen.main.bounds.width)
            
            ButtonOne(text: "A D D", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                
                if (self.title != "") {
                    
                    self.session.loggedInUser?.items.append(Item(title: self.title, task: self.taskToggle, habit: self.habitToggle, dateToggle: self.dateToggle, date: self.date as NSDate, reminderToggle: self.reminderToggle, reminder: self.reminder as NSDate, completed: self.completedToggle, labels: self.selectedLabels, event: self.eventToggle, duration: convertToInterval(interval: eventDuration)))
                    self.session.saveItems(items: self.session.loggedInUser?.items ?? [])
                    self.session.saveLabels(labels: self.session.loggedInUser?.labels ?? [])
                    self.viewRouter.viewRouter = "Dashboard"
                    
                } else {
                    
                    self.showingAlert = true
                }
            }).alert(isPresented: $showingAlert) {
                
                Alert(title: Text("Please add a title!"), dismissButton: .default(Text("Got it!")))
            }.padding(.horizontal)
            
        }.padding()
    }
}

struct MyTextStyle {
    @Binding var focused: Bool
    
    func _body(configuration: Text) -> some View {
        configuration
        .background(
            Color(.red)
        )
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(viewRouter: ViewRouter())
    }
}
