/*
*********************************************************
LWC Name       : recordAlertCardIcon
Created Date    : 9/12/2024
@description    : This component dynamically loads a icon for each record alert based on the Custom Metadata Type Config.
@version        : 1.0
@author         : Andrew Chalon
Modification Log:
- Ver 1.0 [9/12/2024] [Andrew Chalon] Initial Version
*********************************************************
*/

import { LightningElement, api, wire } from 'lwc';
import getStaticResourceUrl from '@salesforce/apex/RecordAlertCardIconController.getStaticResourceUrl';

export default class RecordAlertCardIcon extends LightningElement {
    @api recordAlertCategoryId;
    @api iconUrl;
    @api salesforceIcon
    @api errorMessage;
    @api important;
    icon;

    @wire(getStaticResourceUrl, { recordAlertCategoryId: '$recordAlertCategoryId' })
    wiredResourceUrl({ error, data }) {
        if (data) {
            if(data.includes(':')){
                this.salesforceIcon = data;
            } else {
                this.iconUrl = data;
            }
        } else if (error) {
            this.errorMessage = error.body.message;
            console.log('Record Alerts Card Icon Error:', this.errorMessage);
        }
    }

    get iconVariant(){
        return this.important ? 'error' : '';
    }
}