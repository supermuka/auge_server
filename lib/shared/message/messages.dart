import 'package:intl/intl.dart';

import 'package:auge_server/domain/general/authorization.dart';
import 'package:auge_server/domain/general/organization_directory_service.dart';
import 'package:auge_server/domain/general/user_identity.dart';
import 'package:auge_server/domain/general/group.dart';
import 'package:auge_server/domain/work/work_stage.dart';


class CommonMsg {
  /// Commum Label
  static const String augeLabel = 'auge';
  static const String objectivesWorksLabel = 'Objectives and Works';
  static const String searchLabel = 'Search';
  static const String noCorrespondenceLabel = 'No correspondence';
  static const String filterLabel = 'Filter';
  static const String moreLabel = 'more';
  static const String emptyLabel = 'empty';

  static label(String label) => Intl.select(label, {
    augeLabel: 'AUGE',
    objectivesWorksLabel: 'Objectives and Works',
    searchLabel: 'Search',
    filterLabel: 'Filter',
    moreLabel: 'more',
    emptyLabel: 'empty',
    'other': 'Not Defined'},
      name: "CommonMsg_label",
      args: <String>[label],
      // locale: "en",
      desc: "Common labels",
      examples: const {"AUGE": "AUGE"}
  );

  static const String applyButtonLabel = 'apply';
  static const String editButtonLabel = 'edit';
  static const String deleteButtonLabel = 'delete';
  static const String saveButtonLabel = 'save';
  static const String cancelButtonLabel = 'cancel';
  static const String closeButtonLabel = 'close';
  static const String uploadButtonLabel = 'upload';
  static const String clearButtonLabel = 'clear';
  static const String loginButtonLabel = 'login';
  static const String logoutButtonLabel = 'logout';
  static const String selectPhotoButtonLabel = 'selectPhoto';

  /// Label for edit button
  static buttonLabel(String label) => Intl.select(label, {
        applyButtonLabel: 'Apply',
        editButtonLabel: 'Edit',
        deleteButtonLabel: 'Delete',
        saveButtonLabel: 'Save',
        cancelButtonLabel: 'Cancel',
        closeButtonLabel: 'Close',
        uploadButtonLabel: 'Upload',
        clearButtonLabel: 'Clear',
        loginButtonLabel: 'Login',
        logoutButtonLabel: 'Logout',
        selectPhotoButtonLabel: 'Select Photo',
        'other': 'Not Defined'},
      name: "CommonMsg_buttonLabel",
      args: [label],
      // locale: "en",
      desc: "Label for buttons",
      examples: const {"label": "Edit"}
  );

  static requiredValueMsg() => Intl.message("Enter with a required value");
}

/// Specific messages and labels for [Authentication and Authorization]
class AuthMsg {

  static const String domainLabel = 'domain';
  static const String identificationLabel = 'identification';
  static const String passwordLabel = 'password';
  static const String selectLabel = 'select';
  static const String superAdminLabel = 'superAdmin';
  static const String organizationLabel = 'organization';
  static const String allOrganizationsLabel = 'allOrganizations';
  static const String loginLabel = 'login';
  static const String logoutLabel = 'logout';

  /// Label for [Auth]
  static label(String label) => Intl.select(label, {
        domainLabel: 'name@domain.com',
        identificationLabel: 'Identification',
        passwordLabel: 'Password',
        selectLabel: 'Select',
        superAdminLabel: 'Super Admin',
        organizationLabel: 'Organization',
        allOrganizationsLabel: 'All Organizations',
        loginLabel: 'Login',
        logoutLabel: 'Logout',
        'other': 'Not Defined'},
      name: "AuthMsg_label",
      args: [label],
      // locale: "en",
      desc: "Authentication and authorizations labels",

  );

  static informIdentificationPasswordCorrectlyMsg() => Intl.message("Inform an identification and password correctly.");
  static userNotFoundMsg() => Intl.message("User account not found with the identification and password informed.");
  static organizationNotFoundMsg() => Intl.message("An organization to user account not found.");
  static serverApiErrorMsg() => Intl.message("Server not available.");
  static browserCompatibleErrorMsg() => Intl.message("Browser Compatible: Chrome");

}

/// Specific messages and labels for [AppLayout]
class AppLayoutMsg {

  static const organizationLabel = 'organization';
  static const organizationsLabel = 'organizations';
  static const adminLabel = 'admin';
  static const superAdminLabel = 'superAdmin';
  static const userDetailLabel = 'userDetail';
  static const logoutLabel = 'logout';
  static const ingightsLabel = 'insights';
  static const worksLabel = 'works';
  static const objectivesLabel = 'objectives';
  static const objectivesMapLabel = 'objectivesMap';
  static const objectivesGanttLabel = 'objectivesGantt';
  static const usersLabel = 'users';
  static const groupsLabel = 'groups';
  static const configurationLabel = 'configuration';

  /// Label for [AppLayout]
  static label(String label) => Intl.select(label, {
        organizationLabel: 'Organization',
        organizationsLabel: 'Organizations',
        adminLabel: 'Administration',
        superAdminLabel: 'Super Administration',
        userDetailLabel: 'User Detail',
        logoutLabel: 'Logout',
        ingightsLabel: 'Insights',
        worksLabel: 'Works',
        objectivesLabel: 'Objectives',
        objectivesMapLabel: 'Objectives Map',
        objectivesGanttLabel: 'Objectives Gantt',
        usersLabel: 'Users',
        groupsLabel: 'Groups',
        configurationLabel: 'Configuration',
        'other': 'Not Defined'},
      name: "appLayoutLabel",
      args: [label],
      // locale: "en",
      desc: "Applayout labels",
      examples: const {"Select": "Select"}
  );
}


/// Specific messages and label for [Organization]
class OrganizationMsg {

  static const organizationsLabel = 'organizations';
  static const editOrganizationLabel = 'editOrganization';
  static const addOrganizationLabel = 'addOrganizaation';
  static const organizationDetailLabel = 'organizationDetail';

  /// Label for organization
  static label(String label) => Intl.select(label, {
    organizationsLabel: 'Organizations',
    editOrganizationLabel: 'Edit Organization',
    addOrganizationLabel: 'Add Organization',
    organizationDetailLabel: 'Organization Detail',
    'other': 'Not Defined'},
    name: "OrganizationMsg_Label",
    args: [label],
    // locale: "en",
    desc: "Organization labels",
    examples: const {"Name": "Name"}
  );
}

/// Specific messages and label for [Configuration]
class ConfigurationMsg {

  static const configurationLabel = 'configuration';
  static const serverAndAdminLabel = 'serverAndAdmin';
  static const groupLabel = 'group';
  static const synchronizationLabel = 'synchronization';
  static const generalLabel = 'general';
  static const directoryServiceLabel = 'directoryService';
  static const testConnectionLabel = 'testConnection';
  static const syncAndSaveLabel = 'syncAndSave';

  /// Label for configuration
  static label(String label) => Intl.select(label, {
    configurationLabel: 'Configuration',
    serverAndAdminLabel: 'Server and Admin',
    groupLabel: 'Group',
    synchronizationLabel: 'Synchronization',
    generalLabel: 'General',
    directoryServiceLabel: 'Directory Service',
    testConnectionLabel: 'Test Connection',
    syncAndSaveLabel: 'Sync and Save',
        'other': 'Not Defined'},
      name: "ConfigurationMsg_label",
      args: [label],
      // locale: "en",
      desc: "Configuration labels",
      examples: const {"Name": "Name"}
  );

  /// Label for status configuration
  static statusLabel(int indexLabel) => Intl.select(indexLabel, {
        DirectoryServiceStatus.finished.index: 'Finished.',
        DirectoryServiceStatus.errorException.index: 'An exception occured.',
        DirectoryServiceStatus.errorEmailAttributeNotFound.index: 'Email attribute not found.',
        DirectoryServiceStatus.errorFirstNameAttributeNotFound.index: 'First name attribute not found.',
        DirectoryServiceStatus.errorGroupOrGroupMemberNotFound.index: 'Group or group member not found.',
        DirectoryServiceStatus.errorGroupFilterInvalid.index: 'Group filter invalid.',
        DirectoryServiceStatus.errorLastNameAttributeNotFound.index: 'Last name attribute not found.',
        DirectoryServiceStatus.errorIdentificationAttributeNotFound.index: 'Identification (login) attribute not found.',
        DirectoryServiceStatus.errorUserAttributeForGroupRelationshipNotFound.index: 'User attribute for group relationship not found.',
        DirectoryServiceStatus.errorNotBoundInvalidCredentials.index: 'Not binded. Invalid credentials.',
        DirectoryServiceStatus.errorNotConnected.index: 'Not connected.',
        DirectoryServiceStatus.errorUserNotFound.index: 'User not found.',
        'other': 'Not Defined'},
      name: "ConfigurationMsg_statusLabel",
      args: [label],
      // locale: "en",
      desc: "Status Configuration labels",
      examples: const {"Name": "Name"}
  );

  /// Label for ldap search scope level configuration
  static searchScopeLabel(int indexLabel) => Intl.select(indexLabel, {
        0: 'Base Level',
        1: 'One Level',
        2: 'Sub Level',
        3: 'Subordinate Subtree',
        'other': 'Not Defined'},
      name: "ConfigurationMsg_searchScopeLabel",
      args: [label],
      // locale: "en",
      desc: "Search Scope Configuration labels",
      examples: const {"0": "Name"}
  );

  /// Label for status configuration
  static eventSyncResultLabel(String label) => Intl.select(label, {
        DirectoryServiceEvent
            .entry.toString(): 'Entry',
        DirectoryServiceEvent
            .skipEntry.toString(): 'Skip Entry',
        DirectoryServiceEvent
            .userInsert.toString(): 'User Insert',
        DirectoryServiceEvent
            .userUpdate.toString(): 'User Update',
        DirectoryServiceEvent
            .userDelete.toString(): 'User Delete',
        DirectoryServiceEvent
            .userIdentityInsert.toString(): 'User Identity Insert',
        DirectoryServiceEvent
            .userIdentityUpdate.toString(): 'User Identity Update',
        DirectoryServiceEvent
            .userIdentityDelete.toString(): 'User Identity Delete',
        DirectoryServiceEvent
            .userAccessInsert.toString(): 'User Access Insert',
        DirectoryServiceEvent
            .userAccessUpdate.toString(): 'User Access Update',
        DirectoryServiceEvent
            .userAccessDelete.toString(): 'User Access Delete',
        'other': 'Not Defined'},
      name: "ConfigurationMsg_eventSyncResultLabel",
      args: [label],
      // locale: "en",
      desc: "Event Sync Result Configuration labels",
      examples: const {"Name": "Name"}
  );

}

/// Specific messages and label for [User]
class UserMsg {

  static const usersLabel = 'users';
  static const userLabel = 'user';
  static const editUserLabel = 'editUser';
  static const addUserLabel = 'addUser';
  static const profileLabel = 'profile';
  static const identityLabel = 'identify';
  static const accessLabel = 'access';

  /// Label for user
  static label(String label) => Intl.select(label, {
    usersLabel: 'Users',
    userLabel: 'User',
    editUserLabel: 'Edit User',
    addUserLabel: 'Add User',
    profileLabel: 'Profile',
    identityLabel: 'Identity',
    accessLabel: 'Access',
    'other': 'Not Defined'},
    name: "UserMsg_label",
    args: [label],
    // locale: "en",
    desc: "User labels",
    examples: const {"Name": "Name"}
  );

  static domainOrganizationConfigurationRequiredMsg() => Intl.message("Domain on organization configuration is required.");
  static identificationRequiredMsg() => Intl.message("Identification is required.");
  static invalidIdentificationMsg() => Intl.message("Identification format invalid. Valid format example: id@domain.com");

}

/// Specific messages and label for [UserIdentity]
class UserIdentityMsg {

  /// Label for user
  static label(String label) => Intl.select(label, {
        UserIdentityProvider.internal: 'Internal',
        UserIdentityProvider.directoryService: 'Directory Service',
        'other': 'Not Defined'},
      name: "UserIdentityMsg_label",
      args: [label],
      // locale: "en",
      desc: "User Identity labels",
      examples: const {"Name": "Name"}
  );
}

/// Specific messages and label for [UserAccess]
class UserAccessMsg {

  /// Label for user
  static label(String label) => Intl.select(label, {
        SystemRole.superAdmin: 'Super Admin',
        SystemRole.admin: 'Admin',
        SystemRole.standard: 'Standard',
        'other': 'Not Defined'},
      name: "UserAccessMsg_label",
      args: [label],
      // locale: "en",
      desc: "User Organization Access labels",
      examples: const {"Name": "Name"}
  );
}


/// Specific messages and label for [Work]
class WorkMsg {

  static const String worksLabel = 'works';
  static const String sortedByLabel = 'sortedBy';
  static const String editWorkLabel = 'editWork';
  static const String addWorkLabel = 'addWork';
  static const String objectiveLabel = 'Objective';
  static const String workItemsOverDueLabel = 'workItemsOverDue';
  static const String noMatchLabel = 'No Match';
  static const String selectLabel = 'Select';
  static const String filterWorksLabel = 'Filter Works';

  /// Label for work
  static label(String label) => Intl.select(label, {
    worksLabel: 'Works',
    sortedByLabel: 'Sorted By',
    editWorkLabel: 'Edit Work',
    addWorkLabel: 'Add Work',
    objectiveLabel: 'Objective',
    workItemsOverDueLabel: 'Work Items Over Due',
    noMatchLabel: 'No Match',
    selectLabel: 'Select',
    filterWorksLabel: 'Filter Works',
    'other': 'Not Defined'},
      name: "WorkMsg_label",
      args: [label],
      // locale: "en",
      desc: "Work labels",
      examples: const {"Name": "Name"}
  );
}


/// Specific messages and label for [Stage]
class StageMsg {

  static const workStagesLabel = 'Work Stages';
  static const stageLabel = 'Stage';
  static const selectLabel = 'Select';

  /// Label
  static label(String label) => Intl.select(label, {
    workStagesLabel: 'Work Stages',
    stageLabel: 'Stage',
    selectLabel: 'Select',
     'other': 'Not Defined'},
      name: "stageLabel",
      args: [label],
      // locale: "en",
      desc: "Stage labels"
  );

  static stateNotInfomedMsg() => Intl.message("State not informed.");

}

/// Specific messages and label for [State]
class StateMsg {

  /// Label
  static label(String label) => Intl.select(label, {
        State.notStarted: 'Not Started',
        State.inProgress: 'In Progress',
        State.completed: 'Completed',
        'other': 'Not Defined'},
      name: "StateMsg_label",
      args: [label],
      // locale: "en",
      desc: "State labels"
  );
}


/// Specific messages and label for [WorkItem]
class WorkItemMsg {

  static const String workKanbanLabel = 'workKanban';
  static const String workItemsLabel = 'workItems';
  static const String editWorkItemLabel = 'editWorkItem';
  static const String addWorkItemLabel = 'addWorkItem';
  static const String selectAValueLabel = 'selectAValue';
  static const String workItemsOverDueLabel = 'workItemsOverDue';
  static const String checkItemLabel = 'checkItem';
  static const String noMatchLabel = 'noMatch';
  static const String dropFileHereLabel = 'dropFileHere';

  /// Label for workitem
  static label(String label) => Intl.select(label, {
    workKanbanLabel: 'Work Kanban',
    workItemsLabel: 'Work Items',
    editWorkItemLabel: 'Edit Work Item',
    addWorkItemLabel: 'Add Work Item',
    selectAValueLabel: 'Select a value',
    workItemsOverDueLabel: 'Work Items Over Due',
    checkItemLabel: 'Check Item',
    noMatchLabel: 'No Match',
    dropFileHereLabel: 'Drop File Here',
    'other': 'Not Defined'},
    name: "WorkItemMsg_label",
    args: [label],
    // locale: "en",
    desc: "Work Item labels",
    examples: const {"Name": "Name"}
  );

  static valuePercentIntervalMsg() => Intl.message('The percentual value should be between 0 and 100');

}


/// Specific messages and label for [Objective]
class ObjectiveMsg {

  static const String objectiveLabel = 'objective';
  static const String objectivesLabel = 'objectives';
  static const String addObjectiveLabel = 'addObjective';
  static const String editObjectiveLabel = 'editObjective';
  static const String progressLabel = 'progress';
  static const String noMatchLabel = 'noMatch';
  static const String sortedByLabel = 'sortedBy';
  static const String ultimateObjectiveLabel = 'ultimateObjective';

  /// Label for work
  static label(String label) => Intl.select(label, {
    objectiveLabel: 'Objective',
    objectivesLabel: 'Objectives',
    addObjectiveLabel: 'Add Objective',
    editObjectiveLabel: 'Edit Objective',
    progressLabel: 'Progress',
    noMatchLabel: 'No Match',
    sortedByLabel: 'Sorted By',
    ultimateObjectiveLabel: 'Ultimate Objective',
    'other': 'Not Defined'},
    name: "objectiveLabel",
    args: [label],
    // locale: "en",
    desc: "Objective labels",
    examples: const {"Name": "Name"}
  );
}

/// Specific messages and label for [Map]
class MapMsg {

  static const String objectivesMapLabel = 'objectivesMapLabel';

  /// Label for work
  static label(String label) => Intl.select(label, {
    objectivesMapLabel: 'Objectives Map',
    'other': 'Not Defined'},
    name: "MapMsg_label",
    args: [label],
    // locale: "en",
    desc: "Map labels",
    examples: const {"Leader": "Leader"}
  );

  static notInformedMsg() => Intl.message("Not Informed!");
}

/// Specific messages and label for [Gantt]
class GanttMsg {

  static const String objectivesGanttLabel = 'objectivesGantt';
  /// Label for work
  static label(String label) => Intl.select(label, {
    objectivesGanttLabel: 'Objectives Gantt',
        'other': 'Not Defined'},
      name: "GanttMsg_label",
      args: [label],
      // locale: "en",
      desc: "Gantt labels",
      examples: const {"Group": "Group"}
  );
}

/// Specific messages and label for [Measure]
class MeasureMsg {

  static const String measuresLabel = 'measures';
  static const String editMeasureLabel ='editMeasure';
  static const String addMeasureLabel = 'addMeasure';
  static const String progressLabel = 'progress';
  static final String startValueLabel =  'startValue';
  static final String currentValueLabel =  'currentValue';
  static final String endValueLabel =  'endValue';

  /// Label for Measure
  static label(String label) => Intl.select(label, {
    measuresLabel: 'Measures',
    editMeasureLabel: 'Edit Measure',
    addMeasureLabel: 'Add Measure',
    progressLabel: 'Progress',
    startValueLabel: 'Start Value',
    currentValueLabel: 'Current Value',
    endValueLabel: 'End Value',
        'other': 'Not Defined'},
      name: "MeasureMsg_label",
      args: [label],
      // locale: "en",
      desc: "Measure labels"
  );

  static const String percentLabel = 'percent';
  static const String moneyLabel = 'money';
  static const String indexLabel = 'index';
  static const String unitaryLabel = 'unitary';

  /// Label for Measure Unit
  static measureUnitLabel(String label) => Intl.message(
      "${Intl.select(label, {
        percentLabel: 'Percent',
        moneyLabel: 'Money',
        indexLabel: 'Index',
        unitaryLabel: 'Unitary'})}",
      name: "MeasureMsg_measureUnitLabel",
      args: [label],
      // locale: "en",
      desc: "Measure Unit labels"
  );

  static valueErrorMsg() => Intl.message("Incorret value. Possible reasons: a) Current value should be between Start and End Value. b) Start and End Value are equals.");
  static currentDateNotBetweenStartEndDate(DateTime startDate, DateTime endDate) => Intl.message("Measure progress date should be between objective start date ${DateFormat.yMMMd().format(startDate)} and objective end date ${DateFormat.yMMMd().format(endDate)}.");
  static decimalNumberErrorMsg() => Intl.message("Decimal number should be between 0 and 5.");
}


/// Specific messages and label for [MeasureProgress]
class MeasureProgressMsg {

  static const String measureProgressLabel = 'measureProgress';
  static const String progressCurrentValuesLabel = 'progressCurrentValues';

  /// Label for Measure
  static label(String label) => Intl.select(label, {
    measureProgressLabel: 'Measure Progress',
    progressCurrentValuesLabel: 'Progress Current Values',
    'other': 'Not Defined'},
    name: "MeasureProgressMsg_label",
    args: [label],
    // locale: "en",
    desc: "Measure Progresslabels"
  );

  static valueErrorMsg() => Intl.message("Current value should be between Start and End value.");
  static currentValueExistsAtDate() => Intl.message("Current value already exists at date informed.");
}

/// Specific messages and label for [Group]
class GroupMsg {

  static const String groupsLabel = 'groups';
  static const String editGroupLabel = 'editGroup';
  static const String addGroupLabel = 'addGroup';
  static const String noMatchLabel = 'noMatch';
  static const String activeLabel = 'active';
  static const String inactiveLabel = 'inactive';

  /// Label for Group
  static label(String label) => Intl.select(label, {
    groupsLabel: 'Groups',
    editGroupLabel: 'Edit Group',
    addGroupLabel: 'Add Group',
    noMatchLabel: 'No Match',
    activeLabel: 'Active',
    inactiveLabel: 'Inactive',
    'other': 'Not Defined'},
    name: "GroupMsg_label",
    args: [label],
    // locale: "en",
    desc: "Group labels",
  );

  /// Label for Group Type
  static groupTypeLabel(String label) => Intl.select(label, {
        GroupType.company: 'Company',
        GroupType.businessUnit: 'Business Unit',
        GroupType.department: 'Department',
        GroupType.team: 'Team',
        'other': 'Not Defined'},
      name: "GroupMsg_groupTypeLabel",
      args: [label],
      // locale: "en",
      desc: "Group type labels"
  );
}

/// Specific messages and label for [Insight]
class InsightMsg {

  static const String insightsLabel = 'insights';
  static const String groupLabel = 'group';
  static const String leaderLabel = 'leader';
  static const String objectivesOverallLabel = 'objectivesOverall';
  static const String objectivesMeasuresLabel = 'objectivesAndMeasures';
  static const String worksWorkItemsLabel = 'worksAndWorkItems';
  static const String objectivesLabel = 'objectives';
  static const String objectivesDescriptionLabel = 'objectivesDescription';

  static const String objectivesAchievedLabel = 'objectivesAchieved';
  static const String objectivesAchievedDescriptionLabel = 'objectivesAchievedDescription';
  static const String objectivesRequiringAttentionLabel = 'objectivesRequiringAttention';
  static const String objectivesRequiringAttentionDescriptionLabel = 'objectivesRequiringAttentionDescription';
  static const String measuresLabel = 'measures';
  static const String measuresDescriptionLabel = 'measuresDescription';
  static const String measuresAchievedLabel = 'measuresAchieved';
  static const String measuresAchievedDescriptionLabel = 'measuresArchievedDescription';
  static const String measuresRequiringAttentionLabel = 'measuresRequiringAttention';
  static const String measuresRequiringAttentionDescriptionLabel = 'measuresRequiringAttentionDescription';
  static const String worksLabel = 'works';
  static const String worksDescriptionLabel = 'worksDescription';
  static const String worksCompletedLabel = 'worksCompleted';
  static const String worksCompletedDescriptionLabel = 'worksCompletedDescription';
  static const String worksRequiringAttentionLabel = 'worksRequiringAttention';
  static const String worksRequiringAttentionDescriptionLabel = 'worksRequiringAttentionDescription';
  static const String workItemsLabel = 'workItems';
  static const String workItemsDescriptionLabel = 'workItemsDescription';
  static const String workItemsCompletedLabel = 'workItemsCompleted';
  static const String workItemsCompletedDescriptionLabel = 'workItemsCompletedDescription';
  static const String workItemsRequiringAttentionLabel = 'workItemsRequiringAttention';
  static const String workItemsRequiringAttentionDescriptionLabel = 'workItemsRequiringAttentionDescription';

  /// Label for Insight
  static label(String label) => Intl.select(label, {
    insightsLabel: 'Insights',
    groupLabel: 'Group',
    leaderLabel: 'Leader',
    objectivesOverallLabel: 'Objectives Overall',
    objectivesMeasuresLabel: 'Objectives and Measures',
    worksWorkItemsLabel: 'Works and Work Items',
    objectivesLabel: 'Objectives',
    objectivesDescriptionLabel: 'Number total of objectives',
    objectivesAchievedLabel: 'Objectives Achieved',
    measuresAchievedDescriptionLabel: 'Objectives over 70% progress',
    objectivesRequiringAttentionLabel: 'Objectives Requiring Attention',
    measuresRequiringAttentionDescriptionLabel: 'Objectives below 30% progress',
    measuresLabel: 'Measures',
    measuresDescriptionLabel: 'Number total of measures',
    measuresAchievedLabel: 'Measures Achieved',
    measuresAchievedDescriptionLabel: 'Measures over 70% progress',
    measuresRequiringAttentionLabel: 'Measures Requiring Attention',
    measuresRequiringAttentionDescriptionLabel: 'Measures below 30% progress',
    worksLabel: 'Works',
    worksDescriptionLabel: 'Number total of works',
    worksCompletedLabel: 'Works Completed',
    worksCompletedDescriptionLabel: 'Works with 100% work items completed',
    worksRequiringAttentionLabel: 'Works Requiring Attention',
    worksRequiringAttentionDescriptionLabel: 'Works with over due work items',
    workItemsLabel: 'Work Items',
    workItemsDescriptionLabel: 'Number total of work items',
    workItemsCompletedLabel: 'Work Items Completed',
    workItemsCompletedDescriptionLabel: 'Work items with 100% progress',
    workItemsRequiringAttentionLabel: 'Work Items Requiring Attention',
    workItemsRequiringAttentionDescriptionLabel: 'Over due work items',
    'other': 'Not Defined'},
    name: "InsightMsg_label",
    args: [label],
    // locale: "en",
    desc: "Insight labels",
  );
}

/// Specific messages and label for [SystemFunction]
class SystemFunctionMsg {

  /// Label in past
  static inPastLabel(String functionName) => Intl.select(functionName, {
      SystemFunction.create: 'Created',
      SystemFunction.update: 'Updated',
      SystemFunction.delete: 'Deleted',
      SystemFunction.read: 'Read',
      'other': 'Not Defined'},
    name: "SystemFunctionMsg_inPastLabel",
    args: [functionName],
    // locale: "en",
    desc: "System Function labels",
  );
}

/// Specific messages and label for [TimelineItem] class field
class TimelineItemdMsg {

  static const String timelineLabel = 'timeline';
  static const String dayAgoLabel = 'dayAgo';
  static const String daysAgoLabel = 'daysAgo';
  static const String hourAgoLabel = 'hourAgo';
  static const String hoursAgoLabel = 'hoursAgo';
  static const String minuteAgoLabel = 'minutesAgo';
  static const String minutesAgoLabel = 'minutesAgo';
  static const String secondAgoLabel = 'secondAgo';
  static const String secondsAgoLabel = 'secondsAgo';
  static const String valueLabel = 'value';
  static const String theLabel = 'the';
  static const String changedFromLabel = 'changedFrom';
  static const String wasLabel = 'was';

  /// Label for Insight
  static label(String fieldName) => Intl.select(fieldName, {
    timelineLabel: 'Timeline',
    dayAgoLabel: 'day ago',
    daysAgoLabel: 'days ago',
    hourAgoLabel: 'hour ago',
    hoursAgoLabel: 'hours ago',
    minuteAgoLabel: 'minutes ago',
    minutesAgoLabel: 'minutes ago',
    secondAgoLabel: 'second ago',
    secondsAgoLabel: 'seconds ago',
    valueLabel: 'value',
    theLabel: 'the',
    changedFromLabel: 'changed from',
    wasLabel: 'was',
      'other': 'Not Defined'},
    name: "TimelineItemdMsg_label",
    args: [fieldName],
    // locale: "en",
    desc: "TimelineItem labels",
  );
}

/// Specific messages and label for [TimelineItem] class field
class MailMsg {

  /// Message
  static youIsReceivingThisEMailBecauseYouIsThe() => Intl.message('You is receiving this e-mail because you is the');
  static viewOrReplyIt() => Intl.message('View or reply it on Auge');

}