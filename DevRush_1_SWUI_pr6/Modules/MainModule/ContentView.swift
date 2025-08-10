//
//  ContentView.swift
//  DevRush_1_SWUI_pr6
//
//  Created by Sergey on 05.08.2025.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}

@Observable
class Expenses {
    
    var items = [ExpenseItem]()
    
}

struct ContentView: View {
    
    @State private var showingAddView: Bool = false
    
    @State private var expenses = Expenses()
    
    var body: some View {
        
        NavigationStack {
            List {
                
                ForEach(expenses.items) { item in
                
                    Text(item.name)
                    
                }
                .onDelete(perform: removeItems)
            }
            
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage:  "plus.circle") {
                    showingAddView = true
                }
            }
        }
        
        
        .sheet(isPresented: $showingAddView) {
            AddView(expenses: expenses)
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}
    
#Preview {
    ContentView()
}
