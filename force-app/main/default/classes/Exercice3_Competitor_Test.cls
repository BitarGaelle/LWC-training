/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Exercice3_Competitor_Test {

    @isTest
    static void Ex3_Part2_Test() {
        Account Acc1 = new Account(Name='Acc1');
        Database.insert(Acc1);
        Opportunity opp1 = new Opportunity(Name='opportunity1', AccountId=Acc1.Id, StageName='Qualification', CloseDate=Date.valueOf('2026-12-09'));
        Database.insert(opp1);
        Quote quote1 = new Quote(Name='q1', OpportunityId = opp1.Id);
        Database.insert(quote1);

        Competitor__c comp = new Competitor__c(Name='competitor1', Account__c=Acc1.Id, Quote__c=quote1.Id);

        Database.insert(comp, false);
        //this is a comment to test git
    }
}