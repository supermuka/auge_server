import 'package:intl/intl.dart';

import 'package:auge_server/domain/general/authorization.dart';
import 'package:auge_server/domain/general/organization_directory_service.dart';
import 'package:auge_server/domain/general/user_identity.dart';
import 'package:auge_server/domain/general/group.dart';
import 'package:auge_server/domain/work/work_stage.dart';


class CommonMsg {
  /// Commum Label
  static const String headerTitleLabel = 'headerTitleLabel';
  static const String headerSubtitleLabel = 'headerSubtitleLabel';
  static const String searchLabel = 'searchLabel';
  static const String noCorrespondenceLabel = 'noCorrespondenceLabel';
  static const String filterLabel = 'filterLabel';
  static const String moreLabel = 'moreLabel';
  static const String emptyLabel = 'emptyLabel';

  static label(String label) => Intl.select(label, {
    headerTitleLabel: 'AUGE',
    headerSubtitleLabel: 'Objectives, Work and Performance',
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

  static const String applyButtonLabel = 'applyButtonLabel';
  static const String editButtonLabel = 'editButtonLabel';
  static const String deleteButtonLabel = 'deleteButtonLabel';
  static const String saveButtonLabel = 'saveButtonLabel';
  static const String cancelButtonLabel = 'cancelButtonLabel';
  static const String closeButtonLabel = 'closeButtonLabel';
  static const String uploadButtonLabel = 'uploadButtonLabel';
  static const String clearButtonLabel = 'clearButtonLabel';
  static const String loginButtonLabel = 'loginButtonLabel';
  static const String logoutButtonLabel = 'logoutButtonLabel';
  static const String selectPhotoButtonLabel = 'selectPhotoButtonLabel';

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

  static requiredValueMsg() => Intl.message("Enter with a required value", name: "CommonMsg_requiredValueMsg");
}

/// Specific messages and labels for [Authentication and Authorization]
class AuthMsg {

  static const String domainLabel = 'domainLabel';
  static const String identificationLabel = 'identificationLabel';
  static const String passwordLabel = 'passwordLabel';
  static const String selectLabel = 'selectLabel';
  static const String superAdminLabel = 'superAdminLabel';
  static const String organizationLabel = 'organizationLabel';
  static const String allOrganizationsLabel = 'allOrganizationsLabel';
  static const String loginLabel = 'loginLabel';
  static const String logoutLabel = 'logoutLabel';

  static const String passwordCodeLabel = 'passwordCodeLabel';
  static const String newPasswordLabel = 'newPasswordLabel';
  static const String repeatNewPasswordLabel = 'repeatNewPasswordLabel';

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
    passwordCodeLabel: 'Code',
    newPasswordLabel: 'New Password',
    repeatNewPasswordLabel: 'Repeat New Password',
    'other': 'Not Defined'},
      name: "AuthMsg_label",
      args: [label],
      locale: "en",
      desc: "Authentication and authorizations labels",

  );

  static informIdentificationPasswordCorrectlyMsg() => Intl.message("Inform an identification and password correctly.", name: "AuthMsg_informIdentificationPasswordCorrectlyMsg");
  static userNotFoundMsg() => Intl.message("User account not found with the identification and password informed.", name: "AuthMsg_userNotFoundMsg");
  static organizationNotFoundMsg() => Intl.message("An organization to user account not found.", name: "AuthMsg_organizationNotFoundMsg");
  static serverApiErrorMsg() => Intl.message("Server not available.", name: "AuthMsg_serverApiErrorMsg");
  static browserCompatibleErrorMsg() => Intl.message("Browser Compatible: Chrome", name: "AuthMsg_browserCompatibleErrorMsg");

  // New Password
  static informIdentificationCorrectlyMsg() => Intl.message("Inform an identification correctly.", name: "AuthMsg_informIdentificationCorrectlyMsg");
  static codeNotGeneratedMsg() => Intl.message("Code not generated.", name: "AuthMsg_codeNotGeneratedMsg");
  static informBelowTheCodeSentToEMailMsg() => Intl.message("Inform below the code sent to e-mail", name: "AuthMsg_informBelowTheCodeSentToEMailMsg");
  static codeValidateMsg() => Intl.message("Code validate.", name: "AuthMsg_codeValidateMsg");
  static passwordNotSavedMsg() => Intl.message("Password not saved.", name: "AuthMsg_passwordNotSavedMsg");

}

/// Specific messages and labels for [AppLayout]
class AppLayoutMsg {

  static const organizationLabel = 'organizationLabel';
  static const organizationsLabel = 'organizationsLabel';
  static const adminLabel = 'adminLabel';
  static const superAdminLabel = 'superAdminLabel';
  static const userDetailLabel = 'userDetailLabel';
  static const logoutLabel = 'logoutLabel';
  static const ingightsLabel = 'ingightsLabel';
  static const worksLabel = 'worksLabel';
  static const objectivesLabel = 'objectivesLabel';
  static const objectivesMapLabel = 'objectivesMapLabel';
  static const objectivesGanttLabel = 'objectivesGanttLabel';
  static const usersLabel = 'usersLabel';
  static const groupsLabel = 'groupsLabel';
  static const configurationLabel = 'configurationLabel';

  /// Label for [AppLayout]
  static label(String label) => Intl.select(label, {
        organizationLabel: 'Organization',
        organizationsLabel: 'Organizations',
        adminLabel: 'Administrator',
        superAdminLabel: 'Super Administrator',
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
      name: "AppLayoutMsg_label",
      args: [label],
      // locale: "en",
      desc: "Applayout labels",
      examples: const {"Select": "Select"}
  );
}


/// Specific messages and label for [Organization]
class OrganizationMsg {

  static const organizationsLabel = 'organizationsLabel';
  static const editOrganizationLabel = 'editOrganizationLabel';
  static const addOrganizationLabel = 'addOrganizationLabel';
  static const organizationDetailLabel = 'organizationDetailLabel';

  /// Label for organization
  static label(String label) => Intl.select(label, {
    organizationsLabel: 'Organizations',
    editOrganizationLabel: 'Edit Organization',
    addOrganizationLabel: 'Add Organization',
    organizationDetailLabel: 'Organization Detail',
    'other': 'Not Defined'},
    name: "OrganizationMsg_label",
    args: [label],
    // locale: "en",
    desc: "Organization labels",
    examples: const {"Name": "Name"}
  );
}

/// Specific messages and label for [Configuration]
class ConfigurationMsg {

  static const configurationLabel = 'configurationLabel';
  static const serverAndAdminLabel = 'serverAndAdminLabel';
  static const groupLabel = 'groupLabel';
  static const synchronizationLabel = 'synchronizationLabel';
  static const generalLabel = 'generalLabel';
  static const directoryServiceLabel = 'directoryServiceLabel';
  static const testConnectionLabel = 'testConnectionLabel';
  static const syncAndSaveLabel = 'syncAndSaveLabel';

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
  static statusLabel(String label) => Intl.select(label, {
        DirectoryServiceStatus.finished: 'Finished.',
        DirectoryServiceStatus.errorException: 'An exception occured.',
        DirectoryServiceStatus.errorEmailAttributeNotFound: 'Email attribute not found.',
        DirectoryServiceStatus.errorFirstNameAttributeNotFound: 'First name attribute not found.',
        DirectoryServiceStatus.errorGroupOrGroupMemberNotFound: 'Group or group member not found.',
        DirectoryServiceStatus.errorGroupFilterInvalid: 'Group filter invalid.',
        DirectoryServiceStatus.errorLastNameAttributeNotFound: 'Last name attribute not found.',
        DirectoryServiceStatus.errorIdentificationAttributeNotFound: 'Identification (login) attribute not found.',
        DirectoryServiceStatus.errorUserAttributeForGroupRelationshipNotFound: 'User attribute for group relationship not found.',
        DirectoryServiceStatus.errorNotBoundInvalidCredentials: 'Not binded. Invalid credentials.',
        DirectoryServiceStatus.errorNotConnected: 'Not connected.',
        DirectoryServiceStatus.errorUserNotFound: 'User not found.',
        'other': 'Not Defined'},
      name: "ConfigurationMsg_statusLabel",
      args: [label],
      // locale: "en",
      desc: "Status Configuration labels",
      examples: const {"Name": "Name"}
  );

  static const String baseLevel = 'baseLevel';
  static const String oneLevel = 'oneLevel';
  static const String subLevel = 'subLevel';
  static const String subordinateSubtree = 'subordinateSubtree';

  /// Label for ldap search scope level configuration
  static searchScopeLabel(String label) => Intl.select(label, {
    baseLevel: 'Base Level',
    oneLevel: 'One Level',
    subLevel: 'Sub Level',
    subordinateSubtree: 'Subordinate Subtree',
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
            .entry: 'Entry',
        DirectoryServiceEvent
            .skipEntry: 'Skip Entry',
        DirectoryServiceEvent
            .userInsert: 'User Insert',
        DirectoryServiceEvent
            .userUpdate: 'User Update',
        DirectoryServiceEvent
            .userDelete: 'User Delete',
        DirectoryServiceEvent
            .userIdentityInsert: 'User Identity Insert',
        DirectoryServiceEvent
            .userIdentityUpdate: 'User Identity Update',
        DirectoryServiceEvent
            .userIdentityDelete: 'User Identity Delete',
        DirectoryServiceEvent
            .userAccessInsert: 'User Access Insert',
        DirectoryServiceEvent
            .userAccessUpdate: 'User Access Update',
        DirectoryServiceEvent
            .userAccessDelete: 'User Access Delete',
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

  static const usersLabel = 'usersLabel';
  static const userLabel = 'userLabel';
  static const editUserLabel = 'editUserLabel';
  static const addUserLabel = 'addUserLabel';
  static const profileLabel = 'profileLabel';
  static const identityLabel = 'identityLabel';
  static const accessLabel = 'accessLabel';

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

  static domainOrganizationConfigurationRequiredMsg() => Intl.message("Domain on organization configuration is required.", name: "UserMsg_domainOrganizationConfigurationRequiredMsg");
  static identificationRequiredMsg() => Intl.message("Identification is required.", name: "UserMsg_identificationRequiredMsg");
  static invalidIdentificationMsg() => Intl.message("Identification format invalid. Valid format example: id@domain.com", name: "UserMsg_invalidIdentificationMsg");

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

  static const String worksLabel = 'worksLabel';
  static const String sortedByLabel = 'sortedByLabel';
  static const String editWorkLabel = 'editWorkLabel';
  static const String addWorkLabel = 'addWorkLabel';
  static const String objectiveLabel = 'objectiveLabel';
  static const String workItemsOverDueLabel = 'workItemsOverDueLabel';
  static const String noMatchLabel = 'noMatchLabel';
  static const String selectLabel = 'selectLabel';
  static const String filterWorksLabel = 'filterWorksLabel';

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

  static const workStagesLabel = 'workStagesLabel';
  static const stageLabel = 'stageLabel';
  static const selectLabel = 'selectLabel';

  /// Label
  static label(String label) => Intl.select(label, {
    workStagesLabel: 'Work Stages',
    stageLabel: 'Stage',
    selectLabel: 'Select',
     'other': 'Not Defined'},
      name: "StageMsg_label",
      args: [label],
      // locale: "en",
      desc: "Stage labels"
  );

  static stateNotInfomedMsg() => Intl.message("State not informed.", name: "StageMsg_stateNotInfomedMsg");

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

  static const String workKanbanLabel = 'workKanbanLabel';
  static const String workItemsLabel = 'workItemsLabel';
  static const String editWorkItemLabel = 'editWorkItemLabel';
  static const String addWorkItemLabel = 'addWorkItemLabel';
  static const String selectAValueLabel = 'selectAValueLabel';
  static const String workItemsOverDueLabel = 'workItemsOverDueLabel';
  static const String checkItemLabel = 'checkItemLabel';
  static const String noMatchLabel = 'noMatchLabel';
  static const String dropFileHereLabel = 'dropFileHereLabel';

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

  static valuePercentIntervalMsg() => Intl.message('The percentual value should be between 0 and 100', name: "WorkItemMsg_valuePercentIntervalMsg");

}


/// Specific messages and label for [Objective]
class ObjectiveMsg {

  static const String objectiveLabel = 'objectiveLabel';
  static const String objectivesLabel = 'objectivesLabel';
  static const String addObjectiveLabel = 'addObjectiveLabel';
  static const String editObjectiveLabel = 'editObjectiveLabel';
  static const String progressLabel = 'progressLabel';
  static const String noMatchLabel = 'noMatchLabel';
  static const String sortedByLabel = 'sortedByLabel';
  static const String ultimateObjectiveLabel = 'ultimateObjectiveLabel';

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
    name: "ObjectiveMsg_label",
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

  static notInformedMsg() => Intl.message("Not Informed!", name: "MapMsg_notInformedMsg");
}

/// Specific messages and label for [Gantt]
class GanttMsg {

  static const String objectivesGanttLabel = 'objectivesGanttLabel';
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

  static const String measuresLabel = 'measuresLabel';
  static const String editMeasureLabel ='editMeasureLabel';
  static const String addMeasureLabel = 'addMeasureLabel';
  static const String progressLabel = 'progressLabel';
  static final String startValueLabel =  'startValueLabel';
  static final String currentValueLabel =  'currentValueLabel';
  static final String endValueLabel =  'endValueLabel';

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

  static const String percentLabel = 'percentLabel';
  static const String moneyLabel = 'moneyLabel';
  static const String indexLabel = 'indexLabel';
  static const String unitaryLabel = 'unitaryLabel';

  /// Label for Measure Unit
  static measureUnitLabel(String label) => Intl.select(label, {
        percentLabel: 'Percent',
        moneyLabel: 'Money',
        indexLabel: 'Index',
        unitaryLabel: 'Unitary',
      'other': 'Not Defined'},
      name: "MeasureMsg_measureUnitLabel",
      args: [label],
      // locale: "en",
      desc: "Measure Unit labels"
  );

  static valueErrorMsg() => Intl.message("Incorret value. Possible reasons: a) Current value should be between Start and End Value. b) Start and End Value are equals.", name: "MeasureMsg_valueErrorMsg");
  static currentDateNotBetweenStartEndDate(String startDateFormated, String endDateFormated) => Intl.message("Measure progress date should be between objective start date ${startDateFormated} and objective end date ${endDateFormated}.",
      name: "MeasureMsg_currentDateNotBetweenStartEndDate",
      args: [startDateFormated, endDateFormated]);
  static decimalNumberErrorMsg() => Intl.message("Decimal number should be between 0 and 5.", name: "MeasureMsg_decimalNumberErrorMsg");
}


/// Specific messages and label for [MeasureProgress]
class MeasureProgressMsg {

  static const String measureProgressLabel = 'measureProgressLabel';
  static const String progressCurrentValuesLabel = 'progressCurrentValuesLabel';

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

  static valueErrorMsg() => Intl.message("Current value should be between Start and End value.", name: "MeasureProgressMsg_valueErrorMsg");
  static currentValueExistsAtDate() => Intl.message("Current value already exists at date informed.", name: "MeasureProgressMsg_currentValueExistsAtDate");
}

/// Specific messages and label for [Group]
class GroupMsg {

  static const String groupsLabel = 'groupsLabel';
  static const String editGroupLabel = 'editGroupLabel';
  static const String addGroupLabel = 'addGroupLabel';
  static const String noMatchLabel = 'noMatchLabel';
  static const String activeLabel = 'activeLabel';
  static const String inactiveLabel = 'inactiveLabel';

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

  static const String insightsLabel = 'insightsLabel';
  static const String groupLabel = 'groupLabel';
  static const String leaderLabel = 'leaderLabel';
  static const String objectivesOverallLabel = 'objectivesOverallLabel';
  static const String objectivesMeasuresLabel = 'objectivesMeasuresLabel';
  static const String worksWorkItemsLabel = 'worksWorkItemsLabel';
  static const String objectivesLabel = 'objectivesLabel';
  static const String objectivesDescriptionLabel = 'objectivesDescriptionLabel';

  static const String objectivesAchievedLabel = 'objectivesAchievedLabel';
  static const String objectivesAchievedDescriptionLabel = 'objectivesAchievedDescriptionLabel';
  static const String objectivesRequiringAttentionLabel = 'objectivesRequiringAttentionLabel';
  static const String objectivesRequiringAttentionDescriptionLabel = 'objectivesRequiringAttentionDescriptionLabel';
  static const String measuresLabel = 'measuresLabel';
  static const String measuresDescriptionLabel = 'measuresDescriptionLabel';
  static const String measuresAchievedLabel = 'measuresAchievedLabel';
  static const String measuresAchievedDescriptionLabel = 'measuresAchievedDescriptionLabel';
  static const String measuresRequiringAttentionLabel = 'measuresRequiringAttentionLabel';
  static const String measuresRequiringAttentionDescriptionLabel = 'measuresRequiringAttentionDescriptionLabel';
  static const String worksLabel = 'worksLabel';
  static const String worksDescriptionLabel = 'worksDescriptionLabel';
  static const String worksCompletedLabel = 'worksCompletedLabel';
  static const String worksCompletedDescriptionLabel = 'worksCompletedDescriptionLabel';
  static const String worksRequiringAttentionLabel = 'worksRequiringAttentionLabel';
  static const String worksRequiringAttentionDescriptionLabel = 'worksRequiringAttentionDescriptionLabel';
  static const String workItemsLabel = 'workItemsLabel';
  static const String workItemsDescriptionLabel = 'workItemsDescriptionLabel';
  static const String workItemsCompletedLabel = 'workItemsCompletedLabel';
  static const String workItemsCompletedDescriptionLabel = 'workItemsCompletedDescriptionLabel';
  static const String workItemsRequiringAttentionLabel = 'workItemsRequiringAttentionLabel';
  static const String workItemsRequiringAttentionDescriptionLabel = 'workItemsRequiringAttentionDescriptionLabel';

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

  static const String timelineLabel = 'timelineLabel';
  static const String dayAgoLabel = 'dayAgoLabel';
  static const String daysAgoLabel = 'daysAgoLabel';
  static const String hourAgoLabel = 'hourAgoLabel';
  static const String hoursAgoLabel = 'hoursAgoLabel';
  static const String minuteAgoLabel = 'minuteAgoLabel';
  static const String minutesAgoLabel = 'minutesAgoLabel';
  static const String secondAgoLabel = 'secondAgoLabel';
  static const String secondsAgoLabel = 'secondsAgoLabel';
  static const String valueLabel = 'valueLabel';
  static const String theLabel = 'theLabel';
  static const String changedFromLabel = 'changedFromLabel';
  static const String wasLabel = 'wasLabel';

  /// Label for Insight
  static label(String fieldName) => Intl.select(fieldName, {
    timelineLabel: 'Timeline',
    dayAgoLabel: 'day ago',
    daysAgoLabel: 'days ago',
    hourAgoLabel: 'hour ago',
    hoursAgoLabel: 'hours ago',
    minuteAgoLabel: 'minute ago',
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

/// Specific messages and label for [MailMsg] class field
class MailMsg {

  /// Message to Notification
  static youIsReceivingThisEMailBecauseYouIsThe() => Intl.message('You are receiving this e-mail because you is the', name: "MailMsg_youIsReceivingThisEMailBecauseYouIsThe");
  static viewOrReplyIt() => Intl.message('View or reply it on Auge', name: "MailMsg_viewOrReplyIt");

  /// Message to New Password
  static toDefineNewPasswordInformTheCode() => Intl.message("To define new password inform the code", name: "MailMsg_youIsReceivingThisEMailBecauseNewPasswordWasRequired");

  static youIsReceivingThisEMailBecauseNewPasswordWasRequired() => Intl.message("You are receiving this e-mail because new password was required. Ignore this e-mail if you didn't request new password.", name: "MailMsg_youIsReceivingThisEMailBecauseNewPasswordWasRequired");
  static subjectNewPasswordRequired() => Intl.message('New Password Required', name: "MailMsg_subjectNewPasswordRequired");
  static InformIt() => Intl.message('Inform it on Auge', name: "MailMsg_InformIt");


}