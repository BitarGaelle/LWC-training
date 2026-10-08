import { LightningElement } from 'lwc';

export default class Ex2ParentComponent extends LightningElement {

    parent_counter = 0;
    handleOnClick()
    {
        this.parent_counter++;
    }
}