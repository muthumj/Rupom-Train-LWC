import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountWire.getAccounts';
import getContacts from '@salesforce/apex/AccountWire.getContacts';

export default class TabComp extends LightningElement {


    accountData;
    contactData;

    accountColumns = [
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone' }
    ];

    contactColumns = [
        { label: 'First Name', fieldName: 'FirstName' },
        { label: 'Last Name', fieldName: 'LastName' }
    ];

    @wire(getAccounts)
    wiredAccounts({ data, error }) {
        if (data) {
            this.accountData = data;
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }

    @wire(getContacts)
    wiredContacts({ data, error }) {
        if (data) {
            this.contactData = data;
        } else if (error) {
            console.error('Error fetching contacts:', error);
        }
    }
}