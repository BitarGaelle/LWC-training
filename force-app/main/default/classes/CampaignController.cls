public with sharing class CampaignController {

    @AuraEnabled
    public static void CreateCampMembers(String leadId, List<String> campaignIds){
        if (String.isBlank(leadId) || campaignIds == null || campaignIds.isEmpty()){
            system.debug('empty leadId/campaign ids');
            return;
        }

        List<CampaignMember> membersToAdd = new List<CampaignMember>();
        
        for (String camp: campaignIds)
        {
            CampaignMember cm = new CampaignMember();
            cm.LeadId = leadId;
            cm.CampaignId = camp;
            cm.Status = 'Sent';

            membersToAdd.add(cm);
        }
        if (!membersToAdd.isEmpty()) {
            insert membersToAdd;
        }
    }


    @AuraEnabled(cacheable=true)
    public static List<CampaignWrapper> getCampaigns(Id leadId){
        List<CampaignWrapper> results = new List<CampaignWrapper>();

        List<Campaign> allcampaigns = [SELECT Id, Name, Type, Status, StartDate, EndDate FROM Campaign];

        Set<Id> assignedCampaignIds = new Set<Id>();
        if (leadId != null)
        {
            for (CampaignMember member: [SELECT CampaignId FROM CampaignMember WHERE LeadId =:leadId])
            {
                assignedCampaignIds.add(member.CampaignId);
            }
            System.debug('Assigned campaign Ids: ' + assignedCampaignIds);
        }

        for (Campaign c: allcampaigns) {
            CampaignWrapper wrap = new CampaignWrapper();
            wrap.campaignId = c.Id;
            wrap.campaignName = c.Name;
            wrap.campaignType = c.Type;
            wrap.campaigStatus = c.Status;
            wrap.startdate = c.StartDate;
            wrap.enddate = c.EndDate;
            // Active Campaigns: Campaigns who IsActive field is true. 
            // Retrieve Campaigns where the status is Planned, or In Progress
            if (c.Status == 'Planned' || c.Status == 'In Progress'){
                wrap.isactivestatus = true;
            }
            else {
                wrap.isactivestatus = false;
            }

            wrap.isenrolled = assignedCampaignIds.contains(c.Id);
            results.add(wrap);
            System.debug('Raw wrapper data:' + wrap);
        }
        return results;
    }
    
    public class CampaignWrapper{
        @AuraEnabled public Id campaignId {get;set;}
        @AuraEnabled public String campaignName {get;set;}
        @AuraEnabled public String campaignType {get;set;}
        @AuraEnabled public String campaigStatus {get;set;}
        @AuraEnabled public Date startdate {get;set;}
        @AuraEnabled public Date enddate {get;set;}
        @AuraEnabled public Boolean isactivestatus {get;set;}
        @AuraEnabled public Boolean isenrolled {get;set;}
    }
}