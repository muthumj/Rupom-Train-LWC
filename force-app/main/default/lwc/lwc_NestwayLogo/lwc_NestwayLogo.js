import { LightningElement } from 'lwc';

import nes_logo from '@salesforce/resourceUrl/NestAway_Logo';

export default class Lwc_NestwayLogo extends LightningElement 
{

    
   

    nsm;

    renderedCallback() {
        if (!this.nsm) {
            this.nsm = nes_logo; // Assign static resource URL to nsm if not already assigned
            this.sendImageToParent(); // Automatically send image to parent component
        }
    }

    sendImageToParent() {
        const event = new CustomEvent('sendimagetoparent', {
            detail: {
                imageUrl: this.nsm
            }
        });
        this.dispatchEvent(event);
    }
      

    
}