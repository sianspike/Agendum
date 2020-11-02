//
//  AllItemsView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct AllItemsView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var viewRouter: ViewRouter
    
    @State private var searchText = ""
    @State private var filterClicked = false
    
    func dueSoon(itemDate: NSDate) -> Bool{
        
        let soon = NSDate().addDays(daysToAdd: 7)
        let today = NSDate()
        
        if (itemDate.isLessThanDate(dateToCompare: soon) && itemDate.isGreaterThanDate(dateToCompare: today)) {
            
            return true
        }
        
        return false
    }
    
    func findExcludedItems(item: Item) -> AnyView? {
        
        var isDue = false
        
        if (item.isDateSet()) {
            
            isDue = dueSoon(itemDate: item.getDate()!)
        }
        
        if (item.isHabit() || isDue || item.isCompleted() || item.hasLabels()) {
            
            return nil
        }
        
        return AnyView(ItemElement(item: item))
    }
    
    var body: some View {
        
        ZStack{
            
            VStack (alignment: .leading){
                
                TextWithBottomBorder(text: "A l l  I t e m s")
                
                HStack {
                    
                    Button(action: {filterClicked.toggle()}) {
                        Image(uiImage: UIImage(named: "Icons/Filter.png")!)
                            .renderingMode(.original)
                            .padding(.horizontal)
                    }
                    
                    SearchBarView(text: $searchText)
                }
                
                ScrollView {
                    
                    Group {
                        
                        if (!filterClicked) {
                            
                            ForEach(self.session.loggedInUser?.items.filter({searchText.isEmpty ? true : $0.getTitle().contains(searchText)}).sorted(by: {$0.title < $1.title}) ?? [], id: \.title) { item in
                                
                                let currentItem: Item = item
                                
                                findExcludedItems(item: currentItem)
                            }
                        } else {
                            
                            ForEach(self.session.loggedInUser?.items.filter({searchText.isEmpty ? true : $0.getTitle().contains(searchText)}).sorted(by: {$0.title > $1.title}) ?? [], id: \.title) { item in
                                
                                let currentItem: Item = item
                                
                                findExcludedItems(item: currentItem)
                            }
                        }
                        
                        AllItemsDueSoonView(searchText: searchText, filterClicked: filterClicked)
                        AllItemsHabitView(searchText: searchText, filterClicked: filterClicked)
                        AllItemsLabelView(searchText: searchText, filterClicked: filterClicked)
                        AllItemsCompletedView(searchText: searchText, filterClicked: filterClicked)
                    }
                }
                
                Spacer()
            }
            
            FloatingAddButton(action: {
                self.viewRouter.viewRouter = "Add Item"
            })
        }
    }
}

struct AllItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AllItemsView(viewRouter: ViewRouter())
    }
}

extension NSDate {

    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false

        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }

        //Return Result
        return isGreater
    }

    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false

        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }

        //Return Result
        return isLess
    }

    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false

        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }

        //Return Result
        return isEqualTo
    }

    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays)

        //Return Result
        return dateWithDaysAdded
    }

    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours)

        //Return Result
        return dateWithHoursAdded
    }
}
