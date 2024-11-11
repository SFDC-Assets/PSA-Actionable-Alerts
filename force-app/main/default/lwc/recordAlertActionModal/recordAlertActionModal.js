/*
*********************************************************
LWC Name       : recordAlertActionModal
Created Date    : 9/12/2024
@description    : This component launches actions in a modal for each record alert.
@version        : 1.0
@author         : Andrew Chalon
Modification Log:
- Ver 1.0 [9/12/2024] [Andrew Chalon] Initial Version
*********************************************************
*/

import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class RecordAlertActionModal extends LightningModal {
    @api header;
    @api flowName;
    @api inputVariables;
    @api flowModal = false;
    @api showFooter = false;
    @api showHeader = false;
    @api flowFinish = 'NONE';

    handleStatusChange(event) {
        if (event.detail.status === 'FINISHED') {
            this.close('flow finished: ' + this.flowName);
        }
    }

    handleClose() {
        this.close('modal is closed');
    }
}