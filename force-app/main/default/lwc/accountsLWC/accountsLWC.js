import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import CreateNewAccount from '@salesforce/apex/AccountController.CreateNewAccount';

export default class AccountsLWC extends LightningElement {

    accountName;
    maxRecords;
    accounts;
    errors;

    handleNumbChange(event){
        this.maxRecords = event.target.value;
    }

    handleNameChange(event)
    {
        this.accountName = event.target.value;
    }

    handleClickButton()
    {
        CreateNewAccount({accountName:this.accountName}).then(result =>{
            console.log('Result is: ', result);
        }).catch (error=>{
            console.log('error occured when inserting new account');
        })
    }

    //@wire(getAccounts, {maxRecords: "$maxRecords"}) accounts;
    @wire(getAccounts, {maxRecords:"$maxRecords"}) wiredAccounts({data,errors}){
        if (data) {
            this.accounts = data; this.errors = undefined;
        }else if (errors)
        {
            this.accounts = undefined; this.errors = errors;
        }
    }
}