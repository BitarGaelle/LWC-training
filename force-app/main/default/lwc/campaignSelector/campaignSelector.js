import { LightningElement, api, wire } from 'lwc';
import getCampaigns from '@salesforce/apex/CampaignController.getCampaigns';
import CreatCampMembers from '@salesforce/apex/CampaignController.CreatCampMembers';

export default class CampaignSelector extends LightningElement {
    @api theleadId;
    @api thecampaignId;

    campaignwrappers;
    errors;
    selectedCampIds = [];

    @wire(getCampaigns, { leadId: '$theleadId' }) wiredCampaginResult({data, errors}) {
        if (data){
            this.campaignwrappers = data;
            this.errors = undefined;
        }
        else if (errors){
            this.campaignwrappers = undefined;
            this.errors = errors;
        };
    }

    handleSelection(event)
    {
        campaignId = event.target.value;
        isChecked = event.target.checked;

        if (isChecked){
            if (!this.selectedCampIds.includes(this.campaignId)){
                this.selectedCampIds.push(this.campaignId);
            }
        }
    }
}