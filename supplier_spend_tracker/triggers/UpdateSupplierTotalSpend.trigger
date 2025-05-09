trigger UpdateSupplierTotalSpend on Spend__c (after insert, after update, after delete, after undelete) {
    Set<Id> supplierIds = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Spend__c s : Trigger.new) {
            if (s.Supplier__c != null) supplierIds.add(s.Supplier__c);
        }
    }

    if (Trigger.isUpdate || Trigger.isDelete) {
        for (Spend__c s : Trigger.old) {
            if (s.Supplier__c != null) supplierIds.add(s.Supplier__c);
        }
    }

    List<AggregateResult> results = [
        SELECT Supplier__c, SUM(Amount__c) total
        FROM Spend__c
        WHERE Supplier__c IN :supplierIds
        GROUP BY Supplier__c
    ];

    Map<Id, Decimal> supplierTotals = new Map<Id, Decimal>();
    for (AggregateResult ar : results) {
        supplierTotals.put((Id) ar.get('Supplier__c'), (Decimal) ar.get('total'));
    }

    List<Supplier__c> updates = new List<Supplier__c>();
    for (Id sid : supplierIds) {
        Decimal total = supplierTotals.containsKey(sid) ? supplierTotals.get(sid) : 0;
        updates.add(new Supplier__c(Id = sid, Total_Spend__c = total));
    }

    update updates;
}
