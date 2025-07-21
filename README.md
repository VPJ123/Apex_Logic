# Supplier Spend for Current Year Project

This project is a real-world example of creating an Apex trigger that updates a custom field named `Total_Spend_for_Current_Year__c` on a custom object named `Supplier__c`.

The trigger contains logic to filter and aggregate spend data **only for the current year** by extracting the year portion of the `Spend_Date__c` field.

It runs on the following DML actions: **insert**, **update**, and **delete**.

---

## Objects, Fields, and App

### Obejct: Supplier__c
- Field: Total_Spend_for_Current_Year__c *(Currency)*

### Object: Spend__c
- Field: Spend_Amount__c *(Currency)*
- Field: Supplier__c *(Lookup to Supplier)*
- Field: Spend_Date__c *(Date)*

### App: Supplier Spend Tracker
- Added 2 tabs respectively one for each custom object that displays in the app launcher

---

## Files

### UpdateSupplierTotalSpend.trigger
- This is the trigger that calls a handler to update each 'Supplier__c' record's current year total spend whenever a related 'Spend_Amount__c' record is inserted, updated, or deleted.

### SupplierSpendHandler.cls
- This is the handler class that aggregates current-year 'Spend_Amount__c' and updates each supplier's 'Total_Spend_for_Current_Year__c' field accordingly.

### TestUpdateSupplierTotalSpend.cls
- This is the test class that verifies the trigger correctly calculates and updates a supplier’s current year total spend.

---

## Notes

- This was built in a **personal Salesforce Developer Org**.
