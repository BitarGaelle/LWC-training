public with sharing class Exercice2 {

    public static void countContact(List<Contact> TriggerNew, Map<Id, Contact> oldMap) {

       //if we had duplicate Id balke ma 8ayyarna l account, 8ayyarna l fname - hek ma bi hotta marten bel Set
        Set<Id> All_Ids_Filtered = new Set<Id>(); 
        for(Contact con : TriggerNew)
        {
            //oldmap = null means that i am not inserting a contact
            // the rest check that if that contact in new changed it's firstname, or lastname or its related account
            //then i want this Id for me to check the condition, and get the count for the nb of contact
            if (oldMap == null || (oldMap.get(con.Id).FirstName != con.FirstName || 
                oldMap.get(con.Id).LastName != con.LastName) || oldMap.get(con.Id).AccountId != con.AccountId)
            {
                All_Ids_Filtered.add(con.AccountId);

                if(oldMap != null) {
                    All_Ids_Filtered.add(oldMap?.get(con.Id)?.AccountId); //the id of old account ta kmn terj3 tjebla l size
                }
                //all the account ids that either fname, lname, its related account has changed, meaning i need to update
            }
        }
        if(!All_Ids_Filtered.isEmpty()){
            List<Account> accounts_where_contacts = [SELECT Id, Name, (SELECT Id FROM Contacts WHERE FirstName = null OR LastName = 'Smith')
                                                    FROM Account WHERE Id IN :All_Ids_Filtered];

            for (Account acc : accounts_where_contacts)
            {
                acc.Contact_Count__c = acc.Contacts.size();
                //here we are getting each account, and retrieving the size of its contact list
            }
            update accounts_where_contacts;
        }
    }
}

