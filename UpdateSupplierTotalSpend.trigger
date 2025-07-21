trigger UpdateSupplierTotalSpend on Spend__c (after insert, after update, after delete) {
    if (Trigger.isAfter) {
        SupplierSpendHandler.handleSpendChanges(Trigger.new, Trigger.old, Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete);
    }
}
