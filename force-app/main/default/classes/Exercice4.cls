public with sharing class Exercice4 {
    public static void Modify_Identifier(List<Offer__c> NewList, Map<Id, Offer__c> oldMap) {

        Map<Id, List<Offer__c>> opp_off_ids = new Map<Id, List<Offer__c>>(); //one opportunity can have multiple offers
        for (Offer__c offer : NewList)
        {
            if ((oldMap == null) ||(oldMap.get(offer.Id).Opportunity__c != offer.Opportunity__c))
            {
                if(opp_off_ids.containsKey(offer.Opportunity__c)) {
                    opp_off_ids.get(offer.Opportunity__c).add(offer);
                }
                else {
                    opp_off_ids.put(offer.Opportunity__c, new List<Offer__c>{offer});
                }
            }
        }
        if(!opp_off_ids.isEmpty())
        {
            List<Offer__c> existing_offers = [SELECT Id, Opportunity__r.Id FROM Offer__c WHERE Opportunity__r.Id IN :opp_off_ids.keySet()];

            String dash = '-';
            for (Opportunity opp : [SELECT Id, (SELECT Id FROM Offers__r), Identifier__c FROM Opportunity WHERE Id IN :opp_off_ids.keySet()])
            {
                Integer size_of_offers = opp.Offers__r.size();
                ++size_of_offers;

                for (Offer__c offer : opp_off_ids.get(opp.Id))
                {
                    offer.Identifier__c = opp.Identifier__c + dash + String.valueOf(size_of_offers).leftPad(3, '0');
                    size_of_offers++;
                }

            }
        }
    }
}