/*
*********************************************************
LWC Name       : recordAlertCardAction
Created Date    : 9/12/2024
@description    : This component dynamically loads a button actions in a modal for each record alert based on the Custom Metadata Type Config.
@version        : 1.0
@author         : Andrew Chalon
Modification Log:
- Ver 1.0 [9/12/2024] [Andrew Chalon] Initial Version
*********************************************************
*/

import { LightningElement,api, wire } from 'lwc';
import getCategoryActions from '@salesforce/apex/RecordAlertCardActionController.getCategoryActions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import RecordAlertActionModal from 'c/recordAlertActionModal';

export default class RecordAlertCardAction extends LightningElement {
    @api buttonLabel = 'Take Action';
    @api action;
    @api recordAlertCategoryId;
    @ api recordId;

    @wire(getCategoryActions, {recordAlertCategoryId: '$recordAlertCategoryId'})
    wiredActions({error, data}){
        if (data) {
            this.action = data;
        } else if (error) {
            console.log('Record Alerts Card Action Error:', error);
        }
    }
    
    // openFlow() {
    //     this.flowApiName = this.action; 
    //     console.log('action: ' + this.action);
    //     const flowUrl = `/flow/${flowApiName}?retURL=lightning/page/home`;
    //     window.location.href = flowUrl;
    // };

    openModal() {
        RecordAlertActionModal.open({
            header: this.buttonLabel,
            flowName: this.action, 
            inputVariables: [
                {
                    name: 'recordId', // Replace with your Flow variable name
                    type: 'String', // Replace with the appropriate type
                    value: this.recordId // Replace with the appropriate value
                }
            ],
            flowModal: true,
            showFooter: false,
            showHeader: true
        }).then(result => {
            if (result) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: `${this.buttonLabel} Complete`,
                        message: result.charAt(0).toUpperCase() + result.slice(1),
                        variant: 'success'
                    })
                );
            }
        });
    }
}