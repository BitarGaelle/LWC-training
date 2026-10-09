public with sharing class AccountController {

    @AuraEnabled
    public static string CreateNewAccount(String accountName){
        Account acc = new Account(Name = accountName);
        insert acc;
        return JSON.serialize(acc);
    }

    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(Integer maxRecords) {
        List<Account> accounts = [SELECT Id, Name FROM Account ORDER BY CreatedDate DESC LIMIT :maxRecords];
        return accounts;
    }
}