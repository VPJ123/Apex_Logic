// Initialize the trigger and set the context
trigger UpdateSupplierTotalSpend on Spend__c (after insert, after update, after delete) {

// Double check that the record has been committed to the database
// This is useful for future-proofing in case 'before' triggers are added later on
// If true, then call the handleSpendChanges method
    if (Trigger.isAfter) {
        SupplierSpendHandler.handleSpendChanges(Trigger.new, Trigger.old, Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete);
    }
}
