import { LightningElement, api, wire } from 'lwc';
import getContacts from "@salesforce/apex/AccContactController.getContacts";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from "@salesforce/apex";


export default class RelatedContactmodal extends LightningElement {

    @api recordId; //injected automatically when placed on account record page
    errors;
    contacts;
    isModelOpen = false;


    columns = [
        {label: 'FirstName', fieldName: 'FirstName', type: 'text'},
        {label: 'LastName', fieldName: 'LastName', type: 'text'},
        {label: 'Email', fieldName: 'FirstName', type: 'email'},
        {label: 'Phone', fieldName: 'FirstName', type: 'phone'},
    ];

    @wire(getContacts, { accountId: '$recordId' }) wiredContactsResult({data, errors}) {
        if (data){
            this.contacts = data;
            this.errors = undefined;
        }
        if (errors)
        {
            this.contacts = undefined;
            this.errors = errors;
        }
    }

    handleDelete(event)
    {
        const contactId = event.target.dataset.id;
        console.log(contactId);
        deleteRecord(contactId)
            .then(() => {
                console.log("This contact is deleted");
                return refreshApex(this.wiredContactsResult);
            })
            .catch(error => {
                console.log("error deleting this contact", error.body.message)
            });
    }

    openModal(){
        this.isModelOpen = true;
    }

    closeModal(){
        this.isModelOpen = false;
    }

    handleSuccess(event)
    {
        this.showToast('Success', 'Contact created', 'success');
        this.isModelOpen = false;
        return refreshApex(this.wiredContactsResult);
    }

    handleError(event)
    {
        this.showToast('Error', event.detail.detail, 'error');
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }

}