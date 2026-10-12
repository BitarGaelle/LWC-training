public with sharing class CaseController {

    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(String cNumber){
        system.debug('CNUMMM'+cNumber);
        List<Case> cases;//= [SELECT CaseNumber, Subject, Description, Status FROM Case];
        if(String.isNotBlank(cNumber)){
            system.debug('if');
            cases = [SELECT CaseNumber, Subject, Description, Status FROM Case WHERE CaseNumber LIKE :cNumber];
        }else{
            system.debug('else');
            cases = [SELECT CaseNumber, Subject, Description, Status FROM Case];
        }
        system.debug('cases: '+ cases);
        return cases;
    }

    // @AuraEnabled
    // public static string CreateCase(){

    // }
}