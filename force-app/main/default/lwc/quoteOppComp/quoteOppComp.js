import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import OPP_PICKLIST_FIELD from '@salesforce/schema/Opportunity.Lease_Type__c';
import { NavigationMixin } from 'lightning/navigation'; 


export default class QuoteOppComp extends LightningElement {

    @api recordId;
    isModelOpen = true;
    s_date = '';
    duration_years = 0;

    
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
        this.showToast('Success', 'Quote created', 'success');
        this.isModelOpen = false;
        console.log('success, quote added');
        return refreshApex(this.wiredContactsResult);
    }

    handleError(event)
    {
        this.showToast('Error', event.detail.detail, 'error');
        console.log('error, quote wasnt added', error);
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
    
    handleSubmit(event){
       try{
            event.preventDefault();
            console.log("hello1");
            const fields = event.detail.fields;

            this.s_date = fields.Start_Date__c;
            this.duration_years = parseInt(fields.Duration__c, 10) || 0;
            console.log(this.s_date);
            console.log(this.duration_days);
            if (this.s_date){
                let e_date = new Date(s_date);

                console.log('before set time',e_date)
                e_date.setFullYear(e_date.getFullYear() + this.duration_years);
                console.log("before split: ", e_date);

                fields.End_Date__c = e_date.toLocaleDateString('en-CA');
            }
            this.template.querySelector('lightning-record-edit-form').submit(fields);
       }
       catch (error){
            console.log(error);
       }
    }

}