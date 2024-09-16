import { LightningElement, track } from 'lwc';
import createContact from '@salesforce/apex/ContactController.createContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import EXCAVATOR_IMAGE from '@salesforce/resourceUrl/excavatorImage';

export default class CreateContact extends LightningElement {
    @track contact = {
        FirstName: '',
        LastName: '',
        Email: ''
    };

    excavatorImageUrl = EXCAVATOR_IMAGE;

    handleChange(event) {
        const field = event.target.name;
        this.contact[field] = event.target.value;
    }

    handleSave() {
        createContact({ contactRecord: this.contact })
            .then(result => {
                this.showAlert('Success', 'Contact created successfully!');
                this.handleClear(); // Clear fields after successful creation
            })
            .catch(error => {
                this.showAlert('Error', 'Error inserting contact: ' + error.body.message);
            });
    }

    handleClear() {
        this.contact = {
            FirstName: '',
            LastName: '',
            Email: ''
        };
    }

    showAlert(title, message) {
        alert(`${title}: ${message}`);
    }
}
