import { LightningElement, track, wire } from 'lwc';
import getllbud from '@salesforce/apex/LWC_NestAwat_SearchTab.getallbud';
import deleteContact from '@salesforce/apex/DeleteBudget.deleteContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const colss = [
    { label: 'Budget Name', fieldName: 'Name', type: 'text' },
    { label: 'Budget Amount', fieldName: 'Amount__c', type: 'number' },
    { label: 'Budget Area', fieldName: 'Area__c', type: 'text' }
];

export default class LWC_NestAway_SearchTab extends LightningElement {
    st;
    st1;
    col = colss;
    @track selectedRows = []; // Store selected row IDs

    // Fetch data using wire
    @wire(getllbud, { searchkey: '$st' }) mutubud;

    // Capture search input
    capst(event) {
        this.st1 = event.target.value;
    }

    // Trigger search
    searchme() {
        this.st = this.st1;
    }

    // Handle row selection
    handleRowSelection(event) {
        // Capture the selected rows' Ids
        this.selectedRows = event.detail.selectedRows.map(row => row.Id);
    }

    // Delete selected records
    handleDelete() {
        if (this.selectedRows.length === 0) {
            // Show error if no rows are selected
            this.showToast('Error', 'No budgets selected', 'error');
            return;
        }

        // Call Apex method to delete selected records
        deleteContact({ contactIds: this.selectedRows })
            .then(() => {
                this.showToast('Success', 'Selected budgets deleted successfully', 'success');
                this.refreshTable(); // Call a function to refresh the data table
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    // Show toast notifications
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }

    // Refresh the table after deletion (you will need to implement this logic)
    refreshTable() {
        // Refresh the data in the table by recalling the Apex method or using @wire to refresh data
        return refreshApex(this.mutubud);
    }
}
