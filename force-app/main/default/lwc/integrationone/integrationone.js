import { LightningElement , track } from 'lwc';
import getProductName  from '@salesforce/apex/Integone.getProductName';

export default class Integrationone extends LightningElement {

    @track sku = ''; // Holds the input SKU
    @track productName = ''; // Holds the fetched product name
    @track error; // Holds any error messages

    // Handle input field change
    handleSkuChange(event) {
        this.sku = event.target.value;
    }

    // Handle form submission
    handleFormSubmit(event) {
        event.preventDefault();
        this.error = null;

        // Call the Apex method to get product name
        getProductName({ sku: this.sku })
            .then((result) => {
                this.productName = result || 'No product found';
            })
            .catch((error) => {
                this.error = 'Error fetching product';
                console.error('Error:', error);
            });
    }
    }



