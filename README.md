# Apex_Logic
# Supplier Spend Tracker

This Apex trigger updates the `Total_Spend__c` field on the `Supplier__c` object by aggregating related `Spend__c` records whenever a Spend record is inserted, updated, or deleted.

## Objects Used
- **Supplier__c**
  - `Total_Spend__c` (Currency)
  - `Co_Manufacturing__c` (Checkbox)
- **Spend__c**
  - `Amount__c` (Currency)
  - `Supplier__c` (Lookup to Supplier)

## Files
- `UpdateSupplierTotalSpend.trigger`: The Apex trigger that calculates and updates total spend.
- `TestUpdateSupplierTotalSpend.cls`: A test class to verify the logic and maintain test coverage.

## Notes
- Built in a Trailhead Hands-On Org from scratch.
