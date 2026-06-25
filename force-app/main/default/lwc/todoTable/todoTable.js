import { LightningElement, api, wire } from "lwc";
import { refreshApex } from "@salesforce/apex";
import getTodos from "@salesforce/apex/ET_TodoController.getTodos";
import deleteTodo from "@salesforce/apex/ET_TodoController.deleteTodo";
import TodoForm from "c/todoForm";

const COLUMNS = [
	{ label: "Title", fieldName: "Title", type: "text", wrapText: true },
	{ label: "Status", fieldName: "Status", type: "text" },
	{ label: "Priority", fieldName: "Priority", type: "text" },
	{ label: "Due Date", fieldName: "DueDate", type: "date-local" },
	{
		type: "action",
		typeAttributes: {
			rowActions: [
				{ label: "Edit", name: "edit" },
				{ label: "Delete", name: "delete", iconName: "utility:delete" }
			]
		}
	}
];

export default class TodoTable extends LightningElement {
	@api contactId;
	todos = [];
	wiredResult;
	columns = COLUMNS;
	contactName = "";

	@wire(getTodos, { contactId: "$contactId" })
	wiredTodos(result) {
		this.wiredResult = result;
		if (result.data) {
			this.todos = result.data.todos.map((t) => ({
				Id: t.Id,
				Title: t.Title__c,
				Status: t.Status__c,
				Priority: t.Priority__c,
				DueDate: t.DueDate__c
			}));
			this.contactName = result.data.contact.Name;
		}
	}

	async openForm(record = null) {
		const result = await TodoForm.open({ contactId: this.contactId, record, size: "small" });
		if (result === "saved") await refreshApex(this.wiredResult);
	}

	handleNewTodo() {
		this.openForm();
	}

	handleRowAction(event) {
		const { name } = event.detail.action;
		const row = event.detail.row;

		if (name === "edit") {
			this.openForm(row);
		} else if (name === "delete") {
			// eslint-disable-next-line no-alert
			if (!window.confirm(`Delete "${row.Title}"? This cannot be undone.`)) return;
			deleteTodo({ todoId: row.Id })
				.then(() => refreshApex(this.wiredResult))
				.catch((err) => console.error("Delete failed", err));
		}
	}
}