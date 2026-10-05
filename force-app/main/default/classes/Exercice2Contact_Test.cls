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
public class Exercice2Contact_Test {

    @isTest
    static void countContact_Test() {
        
        Account TestAcc1 = new Account(Name = 'G Bitar');
        Contact TestCon1 = new Contact(FirstName = null, LastName = 'hello', AccountId = TestAcc1.Id);
        Contact TestCon2 = new Contact(FirstName = 'Hello', LastName = 'Smith', AccountId = TestAcc1.Id);

        Test.startTest();
        insert TestAcc1;
        insert TestCon1;
        insert TestCon2;
        Test.stopTest();

        List<Account> contactNumber = [SELECT Contact_Count__c FROM Account WHERE Name = 'G Bitar'];
        Assert.areEqual(3, contactNumber[0]);
    }
}