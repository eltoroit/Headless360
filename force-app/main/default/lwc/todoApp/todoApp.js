import { LightningElement, wire } from "lwc";
import getContacts from "@salesforce/apex/ET_TodoController.getContacts";

export default class TodoApp extends LightningElement {
	selectedContactId;
	contactOptions = [];

	@wire(getContacts)
	wiredContacts({ data }) {
		if (data) {
			this.contactOptions = data.map((c) => ({
				label: c.Name,
				value: c.Id
			}));
		}
	}

	handleContactChange(event) {
		this.selectedContactId = event.detail.value;
	}
}