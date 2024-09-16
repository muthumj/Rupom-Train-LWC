import { LightningElement , track } from 'lwc';
import getitemname  from '@salesforce/apex/Superbatch.getitemname';

export default class SuperbatchInteg extends LightningElement {

    @track skuds ;
    @track postname;
    @track error;

    // Handle the ID input from the user
    handleInputChange(event) {
        this.skuds = event.target.value;
    }

    // Call the Apex method when the user clicks the "Fetch Title" button
    handleFetchTitle() {
        getitemname({ skuds: this.skuds })
            .then(result => {
                this.postname = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error.body.message;
                this.postname = undefined;
            });
    }


}