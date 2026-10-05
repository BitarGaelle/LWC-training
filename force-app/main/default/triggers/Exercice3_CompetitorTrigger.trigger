trigger Exercice3_CompetitorTrigger on Competitor__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    new CompetitorTriggerHandler().run();
}