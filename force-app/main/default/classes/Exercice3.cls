public with sharing class Exercice3 {

    public static void checkCompetitorLinks(List<Competitor__c> newList, Map<Id,Competitor__c> oldMap, Map<Id,Competitor__c> newMap){

        // Creating a map of Account IDs to Competitors. One for the quotes and one for the opps
        Map<Id,Competitor__c> accountIdsToCompetitorForQuotesMap = new Map<Id,Competitor__c>();
        Map<Id,Competitor__c> accountIdsToCompetitorForOppsMap = new Map<Id,Competitor__c>();

        // Looping over the new list of created competitors
        for(Competitor__c comp : newList){

            // If the old map is null (ie: in a create state) or the quote has been changed or the account has been changed
            if(
                (oldMap == null || oldMap.get(comp.Id).Quote__c != comp.Quote__c || oldMap.get(comp.Id).Account__c != comp.Account__c)
                    &&
                (comp.Quote__c != null && comp.Account__c != null)
            ) {
                // Add the account Id and the competitor to the corresponsing map
                accountIdsToCompetitorForQuotesMap.put(comp.Account__c,comp);
            }

            // If the old map is null (ie: in a create state) or the opportunity has been changed or the account has been changed
            if(
                (oldMap == null || oldMap.get(comp.Id).Opportunity__c != comp.Opportunity__c || oldMap.get(comp.Id).Account__c != comp.Account__c)
                    &&
                (comp.Opportunity__c != null && comp.Account__c != null)
            ) {
                // Add the account Id and the competitor to the corresponsing map
                accountIdsToCompetitorForOppsMap.put(comp.Account__c,comp);
            }
        }

        // If the map isn't empty
        if(!accountIdsToCompetitorForQuotesMap.isEmpty()){

            // Looping over all the accounts that have the account ids in the map and quote is not null
            for(Competitor__c comp : [SELECT Id,Account__c FROM Competitor__c WHERE Account__c IN :accountIdsToCompetitorForQuotesMap.keySet() AND Quote__c != null]){

                // If the comprtitor is not part of the current transaction
                if(newMap == null || (newMap != null && !newMap.keySet().contains(comp.Id))){
                    // Getting the competitor from the filled map
                    Competitor__c accountComp = accountIdsToCompetitorForQuotesMap.get(comp.Account__c);

                    // Adding the error
                    accountComp.addError('This account is already related to a quote through a competitor');
                }

            }
        }

        // If the map isn't empty
        if(!accountIdsToCompetitorForOppsMap.isEmpty()){

            // Looping over all the accounts that have the account ids in the map and opportunity is not null
            for(Competitor__c comp : [SELECT Id,Account__c FROM Competitor__c WHERE Account__c IN :accountIdsToCompetitorForOppsMap.keySet() AND Opportunity__c != null]){

                // If the comprtitor is not part of the current transaction
                if(newMap == null || (newMap != null && !newMap.keySet().contains(comp.Id))){
                    // Getting the competitor from the filled map
                    Competitor__c accountComp = accountIdsToCompetitorForOppsMap.get(comp.Account__c);

                    // Adding the error
                    accountComp.addError('This account is already related to an opportunity through a competitor');
                }
            }
        }
    }

    public static void insertCompetitorLinks(List<Competitor__c> newList, Map<Id,Competitor__c> oldMap)
    {

        Map<Id, Id> quote_acc_ids = new Map<Id, Id>();

        for (Competitor__c comp: newList)
        {
            //check for insert, update
            if (oldMap == null || (oldMap.get(comp.Id).Account__c != comp.Account__c || oldMap.get(comp.Id).Quote__c != comp.Quote__c) && comp.Quote__c != null)
            {
                quote_acc_ids.put(comp.Quote__c, comp.Account__c);
            }
        }
        List<Competitor__c> competitor_list = new List<Competitor__c>();
        Integer i = 0;
        for(Quote q : [SELECT Id, OpportunityId FROM Quote WHERE Id IN :quote_acc_ids.keySet()])
        {  
            Competitor__c comp = new Competitor__c(Account__c=quote_acc_ids.get(q.Id), Opportunity__c = q.OpportunityId);
            System.debug(comp.Name);
            competitor_list.add(comp);
            i+=1;
        }
        Database.insert(competitor_list, false);
    }   
}