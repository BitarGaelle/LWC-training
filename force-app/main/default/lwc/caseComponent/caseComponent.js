import { LightningElement, wire } from 'lwc';
// import CreateCase from '@salesforce/apex/CaseController.CreateCase';
import getCases from '@salesforce/apex/CaseController.getCases';

export default class CaseComponent extends LightningElement {

    cases;
    errors;
    caseNb='';

    columns = [
        {label: 'Number', fieldName: 'CaseNumber', type: 'Number'},
        {label: 'Subject', fieldName: 'Subject', type: 'Text'},
        {label: 'Description', fieldName: 'Description', type: 'Text'},
        {label: 'Status', fieldName: 'Status', type: 'Text'}
    ];



    @wire(getCases,{cNumber:"$caseNb"}) wiredCases({errors,data}){
        console.log('dataaaa ',JSON.stringify(data));
        console.log('errors: ',JSON.stringify(errors));
        console.log('caseNumber',this.caseNb);
        if(data){
            this.cases=data;
            this.errors=undefined;
        }
        if(errors){
            this.errors=errors;
            this.cases=undefined;
        }
    }
    handleChange(event)
    {
        this.caseNb = event.target.value;
    }

}