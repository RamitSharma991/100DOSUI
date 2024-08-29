//
//  CustomFilteringDataView.swift
//  CoreDataListingApp
//
//  Created by Ramit Sharma on 23/08/24.
//

import SwiftUI
import CoreData

enum PredicateType {
    case beginsWith
    case contains
    case endsWith
    case equals
    case dateRange
    
    var formatString: String {
        switch self {
        case .beginsWith:
            return "attributeName BEGINSWITH[c] %@"
        case .contains:
            return "attributeName CONTAINS[c] %@"
        case .endsWith:
            return "attributeName ENDSWITH[c] %@"
        case .equals:
            return "attributeName == %@"
        case .dateRange:
            return "date >= %@ AND date <= %@"
        }
    }
}

struct CustomFilteringDataView<Content: View>: View {
    var content: ([Task], [Task]) -> Content
    @FetchRequest private var result: FetchedResults<Task>
    @Binding private var filterData: Date
    private var predicateType: PredicateType
    private var filterValue: Any?
    
    init(filterDate: Binding<Date>, predicateType: PredicateType = .dateRange, filterValue: Any? = nil, @ViewBuilder content: @escaping ([Task], [Task]) -> Content) {
        
        self.content = content
        self._filterData = filterDate
        self.predicateType = predicateType
        self.filterValue = filterValue
        
//        let calendar = Calendar.current
//        let startOfDay = calendar.startOfDay(for: filterDate.wrappedValue)
//        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
        
        let predicate: NSPredicate
        
        if predicateType == .dateRange {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: filterDate.wrappedValue)
            let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
            predicate = NSPredicate(format: predicateType.formatString, argumentArray: [startOfDay, endOfDay])
        } else if let filterValue = filterValue {
            predicate = NSPredicate(format: predicateType.formatString, argumentArray: [filterValue])
        }
        else {
            predicate = NSPredicate(value: true)
        }
        
        _result = FetchRequest(entity: Task.entity(), sortDescriptors: [], predicate: predicate, animation: .easeInOut(duration: 0.25))
        
        
    }
    var body: some View {
        content(seperateTask().0, seperateTask().1)
            .onChange(of: filterData) { newValue in
                updatePredicate(for: newValue)
            }
    }
    
    private func updatePredicate(for newValue: Date) {
        result.nsPredicate = nil
        let predicate: NSPredicate
        
        if predicateType == .dateRange {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: newValue)
            let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
            predicate = NSPredicate(format: predicateType.formatString, argumentArray: [startOfDay, endOfDay])
        } else if let filterValue = filterValue {
            predicate = NSPredicate(format: predicateType.formatString, argumentArray: [filterValue])
        } else {
            predicate = NSPredicate(value: true)
        }
        result.nsPredicate = predicate
    }
    
    func seperateTask() -> ([Task], [Task]) {
        let pendingTasks = result.filter { !$0.isCompleted }
        let completedTasks = result.filter { $0.isCompleted }
        
        return (pendingTasks, completedTasks)
    }
}

#Preview {
    ContentView()
}
