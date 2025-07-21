@isTest
private class TestUpdateSupplierTotalSpend {
    @isTest static void testTriggerLogic() {
        // Step 1: Create Supplier
        Supplier__c supplier = new Supplier__c(Name = 'Test Supplier');
        insert supplier;

        // Step 2: Define Dates
        Date today = Date.today();
        Date lastYear = today.addYears(-1);

        // Step 3: Insert Spend Records
        Spend__c spend1 = new Spend__c(
            Supplier__c = supplier.Id,
            Spend_Amount__c = 100,
            Spend_Date__c = today
        );
        Spend__c spend2 = new Spend__c(
            Supplier__c = supplier.Id,
            Spend_Amount__c = 200,
            Spend_Date__c = lastYear // Should be ignored
        );
        insert new List<Spend__c>{spend1, spend2};

        // Step 4: Verify only current year spend is counted
        supplier = [SELECT Total_Spend_for_Current_Year__c FROM Supplier__c WHERE Id = :supplier.Id];
        System.assertEquals(100, supplier.Total_Spend_for_Current_Year__c, 'Should include only current year spend');

        // Step 5: Update spend amount
        spend1.Spend_Amount__c = 300;
        update spend1;

        supplier = [SELECT Total_Spend_for_Current_Year__c FROM Supplier__c WHERE Id = :supplier.Id];
        System.assertEquals(300, supplier.Total_Spend_for_Current_Year__c, 'Should reflect updated spend');

        // Step 6: Delete spend
        delete spend1;

        supplier = [SELECT Total_Spend_for_Current_Year__c FROM Supplier__c WHERE Id = :supplier.Id];
        System.assertEquals(0, supplier.Total_Spend_for_Current_Year__c, 'Should be zero after deleting all current year spend');
    }
}
