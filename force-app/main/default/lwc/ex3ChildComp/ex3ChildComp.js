import { LightningElement, api } from 'lwc';

export default class Ex3ChildComp extends LightningElement {
    @api isSelected = false;
    @api number;

    get buttonvariantLabel()
    {
        const variantlabel = this.isSelected ? 'brand' : 'destructive';
        return variantlabel;
    }

    get buttonLabel()
    {
        const result = this.isSelected ? 'Selected' : 'Deselected';
        console.log("the button selected is: " , result);
        return result;
    }

    handleButtonClick()
    {
        this.isSelected = !this.isSelected;

        const statusEvent = new CustomEvent('statuschange', {
            detail: {
                status: this.isSelected ? 'Selected' : 'Deselected',
                number: this.number
            }
        });
        this.dispatchEvent(statusEvent);
    }

}