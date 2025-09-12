// Define a class that can be accessed org-wide
public class SupplierSpendHandler {

    // Define a method that can be called without initializing the class
    public static void handleSpendChanges(List<Spend__c> newList, List<Spend__c> oldList, Boolean isInsert, Boolean isUpdate, Boolean isDelete) {

        // LOGIC PART 1:            
        // Initialize a blank set to gather unique supplier record Ids
        Set<Id> supplierIds = new Set<Id>();

        // Runs through a process for records being inserted or updateed
        if (isInsert || isUpdate) {

            // Runs through a loop that checks if a link exists to the supplier object from the spend object (lookup relationship) and if so, adds it to the set
            for (Spend__c s : newList) {
                if (s.Supplier__c != null) {
                    supplierIds.add(s.Supplier__c);
                }
            }
        }

        // Runs through a process for records being deleted
        if (isDelete) {

            // Runs through a loop that checks if a link exists to the supplier object from the spend object (lookup relationship) and if so, adds it to the set
            for (Spend__c s : oldList) {
                if (s.Supplier__c != null) {
                    supplierIds.add(s.Supplier__c);
                }
            }
        }

        // If nothing was added to the list, then the method ends
        if (supplierIds.isEmpty()) return;
        
        // LOGIC PART 2
        // Initialize an Integer variable that holds the current year
        Integer currentYear = Date.today().year();

        // Run a SOQL loop that stores the results in a list called results
        // The SOQL loop provides the supplier name and the sum of the spend called total using a bind variable for the set of supplier Ids and the currentYear variable defined above
        List<AggregateResult> results = [
            SELECT Supplier__c, SUM(Spend_Amount__c) total
            FROM Spend__c
            WHERE Supplier__c IN :supplierIds
              AND CALENDAR_YEAR(Spend_Date__c) = :currentYear
            GROUP BY Supplier__c
        ];

        // Define a map of IDs and Spend
        Map<Id, Decimal> supplierToTotal = new Map<Id, Decimal>();

        // Loops through the List from the SOQL statement transposing the list results to the map
        for (AggregateResult ar : results) {
            supplierToTotal.put((Id) ar.get('Supplier__c'), (Decimal) ar.get('total'));
        }

        // Define a new list for supplier records to be updated
        List<Supplier__c> updates = new List<Supplier__c>();

        // Loop through the supplierId set from logic part 1
        for (Id supplierId : supplierIds) {

            // For each supplier Id provided, get the total from the map
            Decimal total = supplierToTotal.get(supplierId);

            // Adds records to the update list, if the total is null it defaults to 0
            updates.add(new Supplier__c(
                Id = supplierId,
                Total_Spend_for_Current_Year__c = total != null ? total : 0
            ));
        }

        // If the updates list contains values then it performs the update and ends
        if (!updates.isEmpty()) {
            update updates;
        }
    }
}
