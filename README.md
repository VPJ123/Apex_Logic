# Supplier Spend for Current Year Project  
This project is a real-world example of setting up and creating an Apex trigger that updates a custom field named Total_Spend__c on a custom object named Supplier__c.  
The trigger contains logic to filter and aggregate spend only for specifically the current year.  To accomplish this, it extracts the year portion of the Spend_Date__c field.  
The trigger occurs on any of following DML actions: insert, update, or delete.  
  
# Objects, Fields, and Apps Created:  
•	**Object:** Supplier__c  
  o	Field: Total_Spend_for_Current_Year__c (Currency)  
•	**Object:** Spend__c  
  o	Field: Spend_Amount__c (Currency)  
  o	Supplier__c (Lookup to Supplier)  
  o	Spend_Date__c (Date)  
•	**App:** Supplier Spend Tracker  
  o	Added 2 tabs respectively one for each custom object that displays in the app launcher  
  
# Files  
•	UpdateSupplierTotalSpend.trigger  
o	This is the trigger that calls a handler to update each Supplier__c record's current year total spend whenever a related Spend_Amount__c record is inserted, updated, or deleted.  
•	SupplierSpendHandler.cls  
o	This is the handler class that aggregates current-year Spend_Amount__c and updates each supplier's Total_Spend_for_Current_Year__c field accordingly.  
•	TestUpdateSupplierTotalSpend.cls  
o	This is the test class that verifies the trigger correctly calculates and updates a supplier’s current year total spend.  
  
# Notes  
•	This was built out in a personal Developer account.  
