public with sharing class Exercice5 {

    public static void Exercice5(List<Payment__c> ListNew, Map<Id, Payment__c> oldMap) {
        //after insert and after update

        Set<Id> opp_ids = new Set<Id>();
        for (Payment__c payment : ListNew)
        {
            if (oldMap == null || oldMap.get(payment.Id).Status__c != payment.Status__c ||
             oldMap.get(payment.Id).Amount__c != payment.Amount__c || oldMap.get(payment.Id).Opportunity__c != payment.Opportunity__c)
            {
                //own method
                // if (payment.Status__c == 'Paid')
                // {
                //     payment.addError('You cannot delete a paid payment');
                // }
                opp_ids.add(payment.Opportunity__c);
                opp_ids.add(oldMap?.get(payment.Id)?.Opportunity__c);
            }
        }

        if (!opp_ids.isEmpty())
        {
            List<Opportunity> update_opp = new List<Opportunity>();
            system.debug('hello');
            for (Opportunity opp : [SELECT Id, Name, Amount, Total_Paid__c,
                                    (SELECT Id, Status__c, Amount__c, Opportunity__c FROM Payments__r) 
                                    FROM Opportunity WHERE Id IN :opp_ids])
            {
                Decimal total = 0;
                for (Payment__c payment: opp.Payments__r)
                {
                    if (opp.Total_Paid__c > opp.Amount)
                    {
                        opp.addError('Total Paid cannot be greater than amount');
                    }
                    if (payment.Status__c == 'Paid')
                    {
                        total += payment.Amount__c;
                    }
                }
                opp.Total_Paid__c = total;
                update_opp.add(opp);
            }
           update update_opp;
        }
    }
    public static void deleting_method(List<Payment__c> ListOld)
    {
        for (Payment__c payment : ListOld)
        {
            if (payment.Status__c == 'Paid')
            {
                //own method
                payment.addError('You cannot delete a paid payment');
            }
        }
    }
}