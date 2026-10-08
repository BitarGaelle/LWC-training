import { LightningElement, api } from 'lwc';

export default class FirstComponent extends LightningElement {

    @api name = 'Gaelle';
    greeting = 'hello';
}