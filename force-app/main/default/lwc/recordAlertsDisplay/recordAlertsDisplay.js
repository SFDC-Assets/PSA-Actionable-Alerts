/*
*********************************************************
LWC Name       : recordAlertDisplay
Created Date    : 9/12/2024
@description    : This component dynamically loads all record alerts.
                 Button labels are set to default values and can be 
                 controlled from the metadata level.
@version        : 1.1
@author         : Andrew Chalon
Modification Log:
- Ver 1.0 [9/12/2024] [Andrew Chalon] Initial Version
- Ver 1.1 [2/21/2025] [Andrew Chalon] Added default button labels configurable via metadata
*********************************************************
*/

import { LightningElement, api, wire } from 'lwc';
import callMyFlow from '@salesforce/apex/RecordAlertFlowCaller.callMyFlow'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import RecordAlertActionModal from 'c/recordAlertActionModal';
import { refreshApex } from '@salesforce/apex';

export default class RecordAlertsDisplay extends LightningElement {
    @api recordId;
    @api flowDeveloperName;
    @api maximumAlertDisplay;
    @api importantAlertSeverities;
    @api massActionlabel = 'Manage Alerts';
    @api rowButtonLabel = 'Manage Alert';
    @api massActionFlow;
    @api cardHeaderTitle = 'Record Alerts'
    error;
    selectedSeverity = 'all'
    disabledToggle = true;
    disabledFilter = true;
    disabledMassAction = true;
    loading = true;
    showMore = false;
    showSnoozed = false;
    alertIds = [];
    recordAlerts;
    hiddenAlerts = [];

    // Add this property to store the wire result
    wiredAlertsResult;

    @wire(callMyFlow, {
        flowName: '$flowDeveloperName',
        recordId: '$recordId'
    })
    wiredAlerts(result) {
        // Store the wire result
        this.wiredAlertsResult = result;
        const { error, data } = result;
        
        console.log('in @wire');
        console.log('Running: '+ this.flowDeveloperName);
        this.loading = false;
        if (data) {
            this.recordAlerts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.recordAlerts = undefined;
            console.log('Record Alerts Display Error:', this.error);
        }
    }

    async handleRefresh() {
        this.loading = true;
        try {
            // Use the stored wire result
            await refreshApex(this.wiredAlertsResult);
        } catch (error) {
            this.error = error;
        } finally {
            this.loading = false;
        }
    }
    
    get cardTitle(){
        console.log('in get cardTitle()')
        return `${this.cardHeaderTitle} (${this.displayedAlerts ? this.displayedAlerts.length : 0})`;
    }

    get cardFooter(){
        return this.showMore ? 'Show Less' : `Show More (${this.hiddenAlerts.length})`;
    }

    get showMore(){
        console.log('in get showMore()')
        return this.displayedAlerts.length === this.maximumAlertDisplay;
    }

    get isHiddenAlerts(){
        return this.hiddenAlerts.length === 0 ? false : true;
    }

    get showSnoozed(){
        console.log('in get showSnoozed')
        return this.displayedAlerts.filter(alert => alert.SnoozeUntilDate > Date.now()).length > 0 ? true : false;
    }

    get displayedAlerts() {
        console.log('in get displayedAlerts()')
        if (this.recordAlerts){
            // Step 1: Filter alerts by severity
            let alerts = this.filterAlerts(this.recordAlerts);
            console.log('alerts',JSON.stringify(alerts))

            // Step 2: Remove snoozed alerts
            let finalAlerts = this.removeSnoozedAlerts(alerts);

             // Step 3: Show more alerts
            let finalAlerts2 = this.showMoreAlerts(finalAlerts);
            console.log('displayed alerts being finalized', JSON.stringify(finalAlerts2))
            this.disabledToggle = false;
            this.disabledFilter = false;
            this.disabledMassAction = false;
            console.log('booleans reset successfully')

            return finalAlerts2;
        } else {
            return [];
        }
    }

    filterAlerts(alerts){
        console.log('in filterAlerts()')
        if(this.selectedSeverity === 'all'){
            console.log('filter:all')
            return alerts;
        } else {
            console.log('filter:other')
            this.hiddenAlerts = alerts.filter(alert => alert.Severity !== this.selectedSeverity);
            console.log('this.hiddenAlerts after filter', JSON.stringify(this.hiddenAlerts))
            return alerts.filter(alert => alert.Severity === this.selectedSeverity);
        }
    }

    removeSnoozedAlerts(alerts){
        console.log('in removeSnoozedAlerts()')
        if(this.showSnoozed === true){
            console.log('showSnoozed')
            return alerts;
        } else {
            console.log('dontShowSnoozed', Date.now())
            alerts.forEach(alert => {
                console.log('alert.SnoozeUntilDate', alert.SnoozeUntilDate)
                console.log('alert.SnoozeUntilDate > Date.now()', alert.SnoozeUntilDate > this.getCurrentISODateTime())
            })

            return alerts.filter(alert => alert.SnoozeUntilDate < this.getCurrentISODateTime() || !alert.SnoozeUntilDate);
        }
    }

    showMoreAlerts(alerts){
        console.log('in showMoreAlerts()')
        if(this.showMore === true){
            console.log('show more')
            return alerts;
        } else {
            console.log('show less')
            if(this.maximumAlertDisplay){
                this.hiddenAlerts = alerts.slice(this.maximumAlertDisplay)
                return alerts.slice(0, this.maximumAlertDisplay);
            }
        }

    }

    get severityOptions(){
        console.log('in get severityOptions()')
        const uniqueSeverities = new Set();
        
        // this.recordAlerts?.forEach(alert => {
        //     if (alert && alert.Severity) {
        //         uniqueSeverities.add(alert.Severity);
        //     }
        // });
        this.displayedAlerts?.forEach(alert => {
            if (alert && alert.Severity) {
                uniqueSeverities.add(alert.Severity);
            }
        });

        console.log('hidden alerts for options', JSON.stringify(this.hiddenAlerts))
        this.hiddenAlerts?.forEach(alert => {
            if (alert && alert.Severity) {
                uniqueSeverities.add(alert.Severity);
            }
        });

        const options = [
            { label: 'All', value: 'all'},
            ...Array.from(uniqueSeverities).map(severity => {
                return { label: severity, value: severity };
            })
        ];

        console.log('options', JSON.stringify(options))

        return options;
    }

    handleSeverityFilter(event){
        console.log('in get handleSeverityFilter()')
        this.selectedSeverity = event.detail.value;
        this.showMore = false;
    }

    handleToggle(){
        this.showSnoozed = !this.showSnoozed;
    }

    handleAdditionalAlerts(){
        this.showMore = !this.showMore;
    }

    getCurrentISODateTime() {
        const now = new Date();
        return now.toISOString();
    }

    openModal() {
        this.alertIds = [];
        this.displayedAlerts.forEach(alert => {
            this.alertIds.push(alert.Id);
        });

        RecordAlertActionModal.open({
            header: 'Manage Alerts',
            flowName: this.massActionFlow, 
            inputVariables: [
                {
                    name: 'recordIds', // Replace with your Flow variable name
                    type: 'String', // Replace with the appropriate type
                    value: this.alertIds // Replace with the appropriate value
                }
            ],
            flowModal: true,
            showFooter: false,
            showHeader: true
        }).then(result => {
            if (result) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Manage Alerts Complete',
                        message: result.charAt(0).toUpperCase() + result.slice(1),
                        variant: 'success'
                    })
                );
            }
        });
    }



}