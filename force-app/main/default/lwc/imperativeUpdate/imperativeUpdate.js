import { LightningElement , track } from 'lwc';
import updateAccount from '@salesforce/apex/ImperativeUpdateClass.updateAccount';


export default class ImperativeUpdate extends LightningElement {

    @track accountId = '';
    @track accountName = '';
    @track phone = '';
    @track successMessage = '';
    @track errorMessage = '';

    // Handle input changes for Account ID, Account Name, and Phone
    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'accountId') {
            this.accountId = event.target.value;
        } else if (field === 'accountName') {
            this.accountName = event.target.value;
        } else if (field === 'phone') {
            this.phone = event.target.value;
        }
    }

    // Handle the update account process
    handleUpdateAccount() {
        updateAccount({ accountId: this.accountId, accountName: this.accountName, phone: this.phone })
            .then(() => {
                this.successMessage = 'Account updated successfully!';
                this.errorMessage = '';
                this.clearForm();
            })
            .catch(error => {
                this.errorMessage = 'Error updating account: ' + error.body.message;
                this.successMessage = '';
            });
    }

    // Clear form after successful update
    clearForm() {
        this.accountId = '';
        this.accountName = '';
        this.phone = '';
    }



}