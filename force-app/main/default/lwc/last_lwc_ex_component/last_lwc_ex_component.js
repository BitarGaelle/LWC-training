import { LightningElement } from 'lwc';

export default class Last_lwc_ex_component extends LightningElement {

    currentStep = '1';

    get stepOne() { return this.currentStep === '1'; }
    get stepTwo() { return this.currentStep === '2'; }
    get stepThree() { return this.currentStep === '3'; }
    get stepFour() { return this.currentStep === '4'; }

    handleStep(event){
        const targetStep = event.target.value;

        //previous
        if(parseInt(targetStep, 10) < parseInt(this.currentStep, 10)) {
            this.currentStep = targetStep;
            return;
        }
    }
}