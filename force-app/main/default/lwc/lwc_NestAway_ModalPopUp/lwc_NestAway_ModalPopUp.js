import {LightningElement,track} from 'lwc';
import CreateBud from '@salesforce/apex/LWC_NestAway_CreateBudget.CreateBud';


export default class ModalLwc extends LightningElement {
    
    Nam;

    @track showModal = false;
    openModal() {    
        this.showModal = true;
    }
    closeModal() {    
        this.showModal = false;
    }
    capname(event)
    {
        this.Nam= event.target.value;
    }

    Saveme(event)
    {
        CreateBud({Nm : this.Nam}).then(result=>{}).catch(error=>{});
        alert('Your Budget is successfully Created')
    }
    

}