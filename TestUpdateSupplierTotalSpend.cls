// Declare that this is a test
@isTest

// Ensure that the test class is private
private class TestUpdateSupplierTotalSpend {

    // Begin the test to not impact governor limits
    @isTest static void testTriggerLogic() {

        // Step 1: Create a supplier in the Supplier__c object
        Supplier__c supplier = new Supplier__c(Name = 'Test Supplier');
        insert supplier;

        // Step 2: Define test dates
        Date today = Date.today();
        Date lastYear = today.addYears(-1);

        // Step 3: Create, but not inserted yet; a new record into the Spend__c object that should succeed
        Spend__c spend1 = new Spend__c(
            Supplier__c = supplier.Id,
            Spend_Amount__c = 100,
            Spend_Date__c = today
        );

        // Create, but not inserted yet;Insert a new record into the Spend__c object that should be ignored
        Spend__c spend2 = new Spend__c(
            Supplier__c = supplier.Id,
            Spend_Amount__c = 200,
            Spend_Date__c = lastYear
        );

        // Insert the new spend records
        insert new List<Spend__c>{spend1, spend2};

        // Step 4: Verify only current year spend is counted
        supplier = [SELECT Total_Spend_for_Current_Year__c FROM Supplier__c WHERE Id = :supplier.Id];

        // Run the assertion
        System.assertEquals(100, supplier.Total_Spend_for_Current_Year__c, 'Should include only current year spend');

        // Step 5: Update spend amount
        spend1.Spend_Amount__c = 300;
        update spend1;
        supplier = [SELECT Total_Spend_for_Current_Year__c FROM Supplier__c WHERE Id = :supplier.Id];

        // Run the assertion
        System.assertEquals(300, supplier.Total_Spend_for_Current_Year__c, 'Should reflect updated spend');

        // Step 6: Delete spend
        delete spend1;
        supplier = [SELECT Total_Spend_for_Current_Year__c FROM Supplier__c WHERE Id = :supplier.Id];

        // Run the assertion
        System.assertEquals(0, supplier.Total_Spend_for_Current_Year__c, 'Should be zero after deleting all current year spend');
    }
}
