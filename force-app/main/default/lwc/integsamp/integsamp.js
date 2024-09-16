import { LightningElement, track } from 'lwc';
import getPostTitle from '@salesforce/apex/IntegChatclass.getPostTitle';
export default class Integsamp extends LightningElement {


    @track postId;
    @track postTitle;
    @track error;

    // Handle the ID input from the user
    handleInputChange(event) {
        this.postId = event.target.value;
    }

    // Call the Apex method when the user clicks the "Fetch Title" button
    handleFetchTitle() {
        getPostTitle({ postId: this.postId })
            .then(result => {
                this.postTitle = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error.body.message;
                this.postTitle = undefined;
            });
    }
}