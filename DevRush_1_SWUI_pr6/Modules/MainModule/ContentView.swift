//
//  ContentView.swift
//  DevRush_1_SWUI_pr6
//
//  Created by Sergey on 05.08.2025.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}

@Observable
class Expenses {
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        
        if let saveItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: saveItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
        
    }
    
}

struct ContentView: View {
    
    @State private var showingAddView: Bool = false
    
    @State private var expenses = Expenses()
    
    var body: some View {
        
        NavigationStack {
            List {
                
                ForEach(expenses.items) { item in
                
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                    
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
