import LightningModal from 'lightning/modal';
import { api } from 'lwc';
import createTodo from '@salesforce/apex/ET_TodoController.createTodo';
import updateTodo from '@salesforce/apex/ET_TodoController.updateTodo';

const STATUS_OPTIONS = [
    { label: 'Not Started', value: 'Not Started' },
    { label: 'In Progress', value: 'In Progress' },
    { label: 'Completed',   value: 'Completed' }
];

const PRIORITY_OPTIONS = [
    { label: 'High',   value: 'High' },
    { label: 'Medium', value: 'Medium' },
    { label: 'Low',    value: 'Low' }
];

export default class TodoForm extends LightningModal {
    @api contactId;
    @api record;

    title = '';
    status = 'Not Started';
    priority = 'Medium';
    dueDate = '';

    statusOptions = STATUS_OPTIONS;
    priorityOptions = PRIORITY_OPTIONS;

    get modalTitle() {
        return this.record ? 'Edit Task' : 'New Task';
    }

    connectedCallback() {
        if (this.record) {
            this.title = this.record.Title;
            this.status = this.record.Status;
            this.priority = this.record.Priority;
            this.dueDate = this.record.DueDate || '';
        }
    }

    handleChange(event) {
        this[event.target.name] = event.detail.value;
    }

    async handleSave() {
        if (this.record) {
            await updateTodo({
                todoId: this.record.Id,
                title: this.title,
                description: '',
                status: this.status,
                priority: this.priority,
                dueDate: this.dueDate || null
            });
        } else {
            await createTodo({
                title: this.title,
                description: '',
                status: this.status,
                priority: this.priority,
                dueDate: this.dueDate || null,
                contactId: this.contactId
            });
        }
        this.close('saved');
    }

    handleCancel() {
        this.close('cancelled');
    }
}