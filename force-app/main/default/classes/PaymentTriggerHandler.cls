public with sharing class PaymentTriggerHandler extends TriggerHandler implements ITriggerHandler{

    private Map<Id, Payment__c> newMap;
    private Map<Id, Payment__c> oldMap;
    private List<Payment__c> TriggerNew;
    private List<Payment__c> TriggerOld;
    
    public PaymentTriggerHandler(){
        this.newMap = (Map<Id, Payment__c>) Trigger.newMap;
        this.oldMap = (Map<Id, Payment__c>) Trigger.oldMap;
        this.TriggerNew= (List<Payment__c>) Trigger.New;
        this.TriggerOld= (List<Payment__c>) Trigger.Old;
    }
    
    
    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;
    
    //check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
    
    public override void beforeInsert() {
    }
    public override void afterInsert() {
        Exercice5.Exercice5(TriggerNew, oldMap);
    }
    public  override void beforeUpdate() {
    }
    public override void afterUpdate() {
        Exercice5.Exercice5(TriggerNew, oldMap);
    }
    
    public override void beforeDelete() {
        Exercice5.deleting_method(TriggerOld);
    }
    
    public override void afterDelete() {
        
    }
    
    public override void afterUnDelete() {
        
    }
}