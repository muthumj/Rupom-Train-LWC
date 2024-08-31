import { LightningElement } from 'lwc';


export default class Parent extends LightningElement {


    bus;


    handleEvent(event)
    {
        this.bus = event.detail;
    }


}

