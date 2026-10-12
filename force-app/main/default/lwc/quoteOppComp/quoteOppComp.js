import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import OPP_PICKLIST_FIELD from '@salesforce/schema/Opportunity.Lease_Type__c';
import { NavigationMixin } from 'lightning/navigation'; 


export default class QuoteOppComp extends LightningElement {

    @api recordId;
    isModelOpen = true;
    
    @wire(getRecord, {recordId: '$recordId', fields: [OPP_PICKLIST_FIELD]}) opp_record;

    get currLeaseType() {
        return getFieldValue(this.opp_record.data, OPP_PICKLIST_FIELD);
    }

    get isOfficeType(){
        return this.currLeaseType === "Office";
    }

    get isRetailType(){
        return this.currLeaseType === "Retail";
    }

    get isLandType(){
        return this.currLeaseType === "Land";
    }

    openModel(){
        this.isModelOpen = true;
    }

    closeModel(){
        this.isModelOpen = false;
    }

    handleSuccess(event)
    {
        this.showToast('Success', 'Contact created', 'success');
        this.isModelOpen = false;
        return refreshApex(this.wiredContactsResult);
    }

}