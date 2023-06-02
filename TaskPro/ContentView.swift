//
//  ContentView.swift
//  TaskPro
//
//  Created by Siddhant Madhur on 02/06/2023.
//

import SwiftUI

class Reminder {
    var id:String {
        self.name
    }
    var uuid:Int = -1;
    var name:String = "";
    var completed:Bool = false;
    
    init(name:String, uuid: Int) {
        self.name = name
        self.uuid = uuid
    }
    
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var userEntry = "";
    @State var allReminders:[Reminder] = [];
    
    @State var showIncomplete = true;
    @State var showComplete = true;

    func _markAsComplete(idToComp: Int) {
        var tempArr:[Reminder] = [];
        for reminder in allReminders {
            if reminder.uuid != idToComp {
                tempArr.append(reminder)
            }else{
                var completedReminder = Reminder(name:reminder.name, uuid: reminder.uuid)
                completedReminder.completed = true;
                tempArr.append(completedReminder)
            }
        }
        
        allReminders = tempArr
    }
    
    func _markAsIncomplete(idToComp: Int) {
        var tempArr:[Reminder] = [];
        for reminder in allReminders {
            if reminder.uuid != idToComp {
                tempArr.append(reminder)
            }else{
                var completedReminder = Reminder(name:reminder.name, uuid: reminder.uuid)
                completedReminder.completed = false;
                tempArr.append(completedReminder)
            }
        }
        
        allReminders = tempArr
    }
    
    func _addReminder() {
        let newUUID = allReminders.count
        let newReminder = Reminder(name: userEntry, uuid: newUUID)
        if newReminder.name.count > 3 {
            allReminders.append(newReminder)
            
        }
        userEntry = ""
    }
    
    func _removeReminder(idToRem: Int) {
        var tempArr:[Reminder] = [];
        for reminder in allReminders {
            if reminder.uuid != idToRem {
                tempArr.append(reminder)
            }
        }
        
        allReminders = tempArr
    }
    
    @ViewBuilder
    var body: some View {
        
        
        
        GeometryReader { geometry in
            VStack {
                
                ScrollView {
                    VStack {
                        HStack {
                            Button {
                                if showIncomplete {
                                    showIncomplete = false;
                                }else {
                                    showIncomplete = true;
                                }
                            } label: {
                                Text("Incomplete")
                                if showIncomplete {
                                    Image(systemName: "chevron.down")
                                }else {
                                    Image(systemName:"chevron.forward")
                                }
                            }
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black )
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        if showIncomplete {
                            ForEach(allReminders, id:\.name) {task in
                                if task.completed==false{
                                    HStack {
                                        Button {
                                            _markAsComplete(idToComp: task.uuid)
                                        } label: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable(resizingMode: .stretch)
                                                .scaledToFit()
                                                .frame(width: 24.0, height: 24.0)
                                            
                                        }
                                        .foregroundColor(Color.green)
                                        Text(task.name)
                                            .padding(.horizontal, 5)
                                        Spacer()
                                        Button {
                                            _removeReminder(idToRem: task.uuid)
                                        } label: {
                                            Image(systemName: "delete.left.fill")
                                                .resizable(resizingMode: .stretch)
                                                .scaledToFit()
                                                .frame(width: 24.0, height: 24.0)
                                        }
                                        .foregroundColor(Color.red)
                                            
                                            
                                    }
                                    .padding(.vertical, 6.0)
                                }
                            }
                        }
                        HStack {
                            Button {
                                if showComplete {
                                    showComplete = false
                                }else{
                                    showComplete = true
                                }
                            } label: {
                                Text("Complete")
                                if showComplete {
                                    Image(systemName: "chevron.down")
                                }else {
                                    Image(systemName: "chevron.forward")
                                }
                            }
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black )
                            Spacer()
                        }.padding(.vertical, 10)
                        if showComplete {
                            ForEach(allReminders, id:\.name) {task in
                                if task.completed==true{
                                    HStack {
                                        Button {
                                            _markAsIncomplete(idToComp: task.uuid)
                                        } label: {
                                            Image(systemName: "arrow.uturn.forward.circle.fill")
                                                .resizable(resizingMode: .stretch)
                                                .scaledToFit()
                                                .frame(width: 24.0, height: 24.0)
                                            
                                        }
                                        Text(task.name)
                                            .padding(.horizontal, 5)
                                        Spacer()
                                        Button {
                                            _removeReminder(idToRem: task.uuid)
                                        } label: {
                                            Image(systemName: "delete.left.fill")
                                                .resizable(resizingMode: .stretch)
                                                .scaledToFit()
                                                .frame(width: 24.0, height: 24.0)
                                        }
                                        .foregroundColor(Color.red)
                                            
                                            
                                    }
                                    .padding(.vertical, 6.0)
                                }
                            }
                        }
                    }.padding(.vertical, 5)
                }
                Spacer()
                TextField("Reminder", text: $userEntry)
                    .padding(.all, 15.0)
                    .background(Color.blue.opacity(0.15))
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    
                    
                    
                Button {
                    _addReminder()
                } label: {
                    HStack {
                        Spacer()
                        
                        Text("Add Reminder")
                        Spacer()
                            
                    }.foregroundColor(Color.white)
                        .padding(.all, 15.0)
                        .background(Color.blue.opacity(1))
                        .cornerRadius(10)
                        .accessibilityLabel("Add Reminder")
                }.contentShape(Rectangle())
                
            
                Spacer()
                    .frame(height: 24)
                
                
                    
                    
            }.padding(.horizontal, 20.0).frame( height: geometry.size.height-3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
