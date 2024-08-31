import { api } from "lwc";
import { LightningElement  } from 'lwc';

export default class Child extends LightningElement {

@api name = "muthu";

 bus ;

handlechange(event)
{
    this.bus=event.target.value;

    //const searchevent = new CustomEvent('getsearchevent',{detail: this.bus});

    //this.dispatchEvent(searchevent);
}

handleclick(event)
{
    const searchevent = new CustomEvent('getsearchevent',{detail: this.bus});

    this.dispatchEvent(searchevent);
}












}