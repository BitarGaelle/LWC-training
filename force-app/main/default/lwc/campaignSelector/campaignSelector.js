import { LightningElement, api, wire } from 'lwc';
import getCampaigns from '@salesforce/apex/CampaignController.getCampaigns';
import CreateCampMembers from '@salesforce/apex/CampaignController.CreateCampMembers';
import { FlowNavigationNextEvent } from 'lightning/flowSupport';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import CAMPAIGN_TYPE_FIELD from '@salesforce/schema/Campaign.Type';
import FieldApiName from '@salesforce/schema/ProductAttributeSetItem.FieldApiName';

export default class CampaignSelector extends LightningElement {
    @api theleadId;
    @api thecampaignId;
    @api availableActions = []; //for replacing the action from the flow to lwc

    campaignwrappers;
    errors;
    selectedCampIds = [];
    masterCamp = [];

    namefilter = '';
    typefilter = '';
    startdfilter = '';
    enddfilter = '';

    typeOptions = [];

    @wire(getCampaigns, { leadId: '$theleadId' }) wiredCampaignResult({data, errors}) {
        if (data){
            this.campaignwrappers = data;
            this.errors = undefined;
        }
        else if (errors){
            this.campaignwrappers = undefined;
            this.errors = errors;
        };
        console.log('wrapper from js:', JSON.stringify(this.campaignwrappers));
    }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: CAMPAIGN_TYPE_FIELD})
    wiredPicklist({ data, error }) {
        if (data)
        {
            this.typeOptions = [
                {label: 'All Types', value: ''},
                ...data.values.map(item => ({
                label: item.label,
                value: item.value
                }))
            ];
            this.errors = undefined;
        }
        else if (error) {
            this.typeOptions = [];
            this.errors = error;
        }
    }

    handleSelection(event)
    {
        let campaignId = event.target.value;
        let isChecked = event.target.checked;

        if (isChecked){
            if (!this.selectedCampIds.includes(campaignId)){
                this.selectedCampIds.push(campaignId);
            }
            console.log('selectedCampIds: ',JSON.stringify(this.selectedCampIds));
        }
        else{
            this.selectedCampIds = this.selectedCampIds.filter(id => id != campaignId);
        }
    }
    
    handleContinue() {
        if (this.selectedCampIds.length === 0)
        {
            alert('please select at least one campaign to assign');
            return;
        }

        CreateCampMembers({
            leadId: this.theleadId,
            campaignIds: this.selectedCampIds
        })
        .then(() => {
            if (this.availableActions.find(action => action === 'Continue')) {
                const navigNextEvent = new FlowNavigationNextEvent();
                this.dispatchEvent(navigNextEvent);
            }
        })

        .catch(error => {
            this.errors = error.body.message;
            alert('Error creating records: ', this.errors);
            console.log(this.errors);
        });
    }

    handleCancel(){
        if (this.availableActions.find(action => action === 'Cancel')) {
            const navigNextEvent = new FlowNavigationNextEvent();
            this.dispatchEvent(navigNextEvent);
        }
    }
    
    handleFilterChange(event){
        const filterName = event.target.name;
        const filterVal = event.target.value;

        if (filterName === 'nameFilter'){
            this.namefilter = filterVal.toLowerCase();
        }else if (filterName === 'typeFilter') {
            this.typefilter = filterVal;
        } else if (filterName === 'startDateFilter') {
            this.startdfilter = filterVal;
        }else if (filterName === 'endDateFilter') {
            this.enddfilter = filterVal; 
        }
    }

    get filteredCamp() {
        if (!this.campaignwrappers) return [];

        return this.campaignwrappers.filter(camp => {
            const matchesName = !this.namefilter ||
                (camp.campaignName && camp.campaignName.toLowerCase().includes(this.namefilter));

            const matchesType = !this.typefilter ||
                (camp.campaignType === this.typefilter);

            const matchesStartDate = !this.startdfilter ||
                (camp.startdate && camp.startdate >= this.startdfilter);
            
            const matchesEndDate = !this.enddfilter ||
                (camp.enddate && camp.enddate <= this.enddfilter);
            
            return matchesName && matchesType && matchesStartDate && matchesEndDate
        });
    }
}