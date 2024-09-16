import { LightningElement , track } from 'lwc';

import createAccount from '@salesforce/apex/ImperativeClass.createAccount';

export default class ImperativeInsert extends LightningElement {

    @track accountName = '';
    @track phone = '';
    @track successMessage = '';

    // Handle input change for both Account Name and Phone fields
    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'accountName') {
            this.accountName = event.target.value;
        } else if (field === 'phone') {
            this.phone = event.target.value;
        }
    }

    // Handle the creation of the Account record
    handleCreateAccount() {
        createAccount({ accountName: this.accountName, phone: this.phone })
            .then(result => {
                this.successMessage = 'Account created successfully. Account ID: ' + result;
                this.clearForm();
            })
            .catch(error => {
                this.successMessage = 'Error creating account: ' + error.body.message;
            });

        }

        // Clear the form after successful account creation
        clearForm() {
            this.accountName = '';
            this.phone = '';
        }



}