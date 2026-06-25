User guestUser = [
    SELECT Id FROM User
    WHERE Name = 'Headless360 Portal Site Guest User'
    AND IsActive = true
    LIMIT 1
];
PermissionSet ps = [
    SELECT Id FROM PermissionSet
    WHERE Name = 'ET_Todo_GuestAccess'
    LIMIT 1
];
List<PermissionSetAssignment> existing = [
    SELECT Id FROM PermissionSetAssignment
    WHERE AssigneeId = :guestUser.Id
    AND PermissionSetId = :ps.Id
    LIMIT 1
];
if (existing.isEmpty()) {
    insert new PermissionSetAssignment(AssigneeId = guestUser.Id, PermissionSetId = ps.Id);
    System.debug('Guest permissions assigned.');
} else {
    System.debug('Guest permissions already assigned — skipping.');
}
