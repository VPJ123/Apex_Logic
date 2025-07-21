# Supplier Spend for Current Year Project

This project is a real-world example of creating an Apex trigger that updates a custom field named `Total_Spend_for_Current_Year__c` on a custom object named `Supplier__c`.

The trigger contains logic to filter and aggregate spend data **only for the current year** by extracting the year portion of the `Spend_Date__c` field.

It runs on the following DML actions: **insert**, **update**, and **delete**.

---

## Objects, Fields, and App

### `Supplier__c`
- `Total_Spend_for_Current_Year__c` (Currency)

### `Spend__c`
- `Spend_Amount__c` (Currency)
- `Supplier__c` (Lookup to Supplier)
- `Spend_Date__c` (Date)

### App: *Supplier Spend Tracker*
- Includes tabs for both custom objects for visibility in the App Launcher

---

## Files

### `UpdateSupplierTotalSpend.trigger`
- This trigger calls a handler to update each `Supplier__c` record’s current year total spend whenever a related `Spend__c` record is inserted, updated, or deleted.

### `SupplierSpendHandler.cls`
- The handler class aggregates current-year `Spend_Amount__c` values and updates the corresponding supplier's `Total_Spend_for_Current_Year__c` field.

### `TestUpdateSupplierTotalSpend.cls`
- The test class verifies that the trigger correctly calculates and updates a supplier’s current year total spend on insert, update, and delete operations.

---

## Notes

- This was built in a **personal Salesforce Developer Org**.
