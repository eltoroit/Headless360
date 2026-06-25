public without sharing class ET_CloseMasterCase {

    public class Output {
        @InvocableVariable(label='Close Result')
        public String closeResult;
    }

    @InvocableMethod(label='Close Master Case' description='Closes the open master case and lets Flow 2 cascade-close child cases')
    public static List<Output> closeMaster(List<String> inputs) {
        List<Case> masters = [
            SELECT Id, Subject
            FROM Case
            WHERE IsMaster__c = true
            AND Status != 'Closed'
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];

        Output out = new Output();
        if (masters.isEmpty()) {
            out.closeResult = 'No open master case found.';
            return new List<Output>{ out };
        }

        Case master = masters[0];
        master.Status = 'Closed';
        update master;

        out.closeResult = 'Master case "' + master.Subject + '" is now Closed. Flow 2 will cascade-close all linked child cases automatically.';
        return new List<Output>{ out };
    }
}