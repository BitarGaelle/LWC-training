import { LightningElement } from 'lwc';

export default class Ex3ParentComp extends LightningElement {

    child1Status = '';
    child2Status = '';

    handleChange(event)
    {
        console.log('event.number:',event.detail.number);
        if(event.detail.number==='1'){
            this.child1Status=event.detail.status;
        }
        if(event.detail.number==='2'){
            this.child2Status=event.detail.status;
        }

        console.log('child1Status::'+this.child1Status);
        console.log('child2Status::'+this.child2Status);
    }
    
}