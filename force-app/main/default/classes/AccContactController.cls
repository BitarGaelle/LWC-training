public with sharing class AccContactController {

    @AuraEnabled(cacheable=true)
    public static list<Contact> getContacts(Id accountId) {
        return [SELECT Id, FirstName, LastName, Email,
        Phone FROM Contact WHERE AccountId =:accountId];
    }

}