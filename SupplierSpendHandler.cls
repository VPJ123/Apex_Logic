public class SupplierSpendHandler {
    public static void handleSpendChanges(List<Spend__c> newList, List<Spend__c> oldList, Boolean isInsert, Boolean isUpdate, Boolean isDelete) {
        Set<Id> supplierIds = new Set<Id>();

        if (isInsert || isUpdate) {
            for (Spend__c s : newList) {
                if (s.Supplier__c != null) {
                    supplierIds.add(s.Supplier__c);
                }
            }
        }

        if (isDelete) {
            for (Spend__c s : oldList) {
                if (s.Supplier__c != null) {
                    supplierIds.add(s.Supplier__c);
                }
            }
        }

        if (supplierIds.isEmpty()) return;

        Integer currentYear = Date.today().year();

        List<AggregateResult> results = [
            SELECT Supplier__c, SUM(Spend_Amount__c) total
            FROM Spend__c
            WHERE Supplier__c IN :supplierIds
              AND CALENDAR_YEAR(Spend_Date__c) = :currentYear
            GROUP BY Supplier__c
        ];

        Map<Id, Decimal> supplierToTotal = new Map<Id, Decimal>();
        for (AggregateResult ar : results) {
            supplierToTotal.put((Id) ar.get('Supplier__c'), (Decimal) ar.get('total'));
        }

        List<Supplier__c> updates = new List<Supplier__c>();
        for (Id supplierId : supplierIds) {
            Decimal total = supplierToTotal.get(supplierId);
            updates.add(new Supplier__c(
                Id = supplierId,
                Total_Spend_for_Current_Year__c = total != null ? total : 0
            ));
        }

        if (!updates.isEmpty()) {
            update updates;
        }
    }
}
