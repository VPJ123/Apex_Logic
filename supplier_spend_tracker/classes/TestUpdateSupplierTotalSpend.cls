@isTest
private class TestUpdateSupplierTotalSpend {
    
    @isTest
    static void testSpendTrigger() {
        Supplier__c supplier = new Supplier__c(Name = 'Test Supplier', Co_Manufacturing__c = true);
        insert supplier;

        Spend__c spend1 = new Spend__c(Supplier__c = supplier.Id, Amount__c = 100);
        Spend__c spend2 = new Spend__c(Supplier__c = supplier.Id, Amount__c = 50);
        insert new List<Spend__c>{spend1, spend2};

        Supplier__c updatedSupplier = [
            SELECT Total_Spend__c FROM Supplier__c WHERE Id = :supplier.Id
        ];
        System.assertEquals(150, updatedSupplier.Total_Spend__c);

        spend2.Amount__c = 200;
        update spend2;

        updatedSupplier = [
            SELECT Total_Spend__c FROM Supplier__c WHERE Id = :supplier.Id
        ];
        System.assertEquals(300, updatedSupplier.Total_Spend__c);

        delete spend1;

        updatedSupplier = [
            SELECT Total_Spend__c FROM Supplier__c WHERE Id = :supplier.Id
        ];
        System.assertEquals(200, updatedSupplier.Total_Spend__c);
    }
}
