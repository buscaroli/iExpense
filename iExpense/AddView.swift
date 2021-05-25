//
//  AddView.swift
//  iExpense
//
//  Created by Matteo on 25/05/2021.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @ObservedObject var expenses: Expenses
    
    static let types = ["Business", "Personal"]
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new Expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
