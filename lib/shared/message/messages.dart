import 'package:auge_server/model/general/organization_directory_service.dart';
import 'package:intl/intl.dart';

class CommonMsg {

  /// Commum Label
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'AUGE': 'AUGE',
        'Objectives and Works': 'Objectives and Works',
        'other': 'Not Defined'})}",
      name: "label",
      args: [label],
      // locale: "en",
      desc: "Common labels",
      examples: const {"AUGE": "Auge"}
  );

  /// Label for edit button
  static buttonLabel(String label) => Intl.message(
      "${Intl.select(label, {
        'Apply': 'Apply',
        'Edit': 'Edit',
        'Delete': 'Delete',
        'Save': 'Save',
        'Cancel': 'Cancel',
        'Close': 'Close',
        'Upload': 'Upload',
        'Clear': 'Clear',
        'Login': 'Login',
        'Logout': 'Logout',
        'Select Photo': 'Select Photo',
        'other': 'Not Defined'})}",
      name: "buttonLabel",
      args: [label],
      // locale: "en",
      desc: "Label for buttons",
      examples: const {"label": "Edit"}
  );

  static requiredValueMsg() => Intl.message("Enter with a required value");
}


/// Specific messages and labels for [Authentication and Authorization]
class AuthMsg {

  /// Label for [Auth]
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'name@domain.com': 'name@domain.com',
        'Identification': 'Identification',
        'Password': 'Password',
        'Select': 'Select',
        'Super Admin': 'Super Admin',
        'Organization': 'Organization',
        'All Organizations': 'All Organizations',
        'Login': 'Login',
        'Logout': 'Logout',
        'other': 'Not Defined'})}",
      name: "loginLabel",
      args: [label],
      // locale: "en",
      desc: "Authentication and authorizations labels",
      examples: const {"eMail": "e-mail"}
  );

  static informIdentificationPasswordCorrectlyMsg() => Intl.message("Inform an identification and password correctly.");
  static userNotFoundMsg() => Intl.message("User account not found with the identification and password informed.");
  static organizationNotFoundMsg() => Intl.message("An organization to user account not found.");
  static serverApiErrorMsg() => Intl.message("Server not available.");
  static browserCompatibleErrorMsg() => Intl.message("Browser Compatible: Chrome");

}

/// Specific messages and labels for [AppLayout]
class AppLayoutMsg {

  /// Label for [AppLayout]
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Organization': 'Organization',
        'Organizations': 'Organizations',
        'Admin': 'Administration',
        'SuperAdmin': 'Super Administration',
        'User Detail': 'User Detail',
        'Logout': 'Logout',
        'Insights': 'Insights',
        'Works': 'Works',
        'Objectives': 'Objectives',
        'Objectives Map': 'Objectives Map',
        'Objectives Gantt': 'Objectives Gantt',
        'Users': 'Users',
        'Groups': 'Groups',
        'Configuration': 'Configuration',
        'other': 'Not Defined'})}",
      name: "appLayoutLabel",
      args: [label],
      // locale: "en",
      desc: "Applayout labels",
      examples: const {"Select": "Select"}
  );
}


/// Specific messages and label for [Organization]
class OrganizationMsg {

  /// Label for organization
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Organizations': 'Organizations',
        'Edit Organization': 'Edit Organization',
        'Add Organization': 'Add Organization',
        'Organization Detail': 'Organization Detail',
        'other': 'Not Defined'})}",
      name: "organizationLabel",
      args: [label],
      // locale: "en",
      desc: "Organization labels",
      examples: const {"Name": "Name"}
  );
}

/// Specific messages and label for [Configuration]
class ConfigurationMsg {

  /// Label for configuration
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Configuration': 'Configuration',
        'Server and Admin': 'Server and Admin',
        'Group': 'Group',
        'Synchronization': 'Synchronization',
        'General': 'General',
        'Directory Service': 'Directory Service',
        'Test Connection': 'Test Connection',
        'Sync and Save': 'Sync and Save',
        'other': 'Not Defined'})}",
      name: "configurationLabel",
      args: [label],
      // locale: "en",
      desc: "Configuration labels",
      examples: const {"Name": "Name"}
  );

  /// Label for status configuration
  static statusLabel(int indexLabel) => Intl.message(
      "${Intl.select(indexLabel, {
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
        'other': 'Not Defined'})}",
      name: "statusConfigurationLabel",
      args: [label],
      // locale: "en",
      desc: "Status Configuration labels",
      examples: const {"Name": "Name"}
  );

  /// Label for ldap search scope level configuration
  static searchScopeLabel(int indexLabel) => Intl.message(
      "${Intl.select(indexLabel, {
        0: 'Base Level',
        1: 'One Level',
        2: 'Sub Level',
        3: 'Subordinate Subtree',
        'other': 'Not Defined'})}",
      name: "searchScopeLabel",
      args: [label],
      // locale: "en",
      desc: "Search Scope Configuration labels",
      examples: const {"0": "Name"}
  );

  /// Label for status configuration
  static eventSyncResultLabel(String label) => Intl.message(
      "${Intl.select(label, {
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
        'other': 'Not Defined'})}",
      name: "eventSyncResultConfigurationLabel",
      args: [label],
      // locale: "en",
      desc: "Event Sync Result Configuration labels",
      examples: const {"Name": "Name"}
  );

}

/// Specific messages and label for [User]
class UserMsg {

  /// Label for user
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Users': 'Users',
        'User': 'User',
        'Edit User': 'Edit User',
        'Add User': 'Add User',
        'Profile': 'Profile',
        'Identity': 'Identity',
        'Access': 'Access',
        'other': 'Not Defined'})}",
      name: "userLabel",
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
  static label(String label) => Intl.message(
      "${Intl.select(label, {

        'UserIdentityProvider.internal': 'Internal',
        'UserIdentityProvider.directoryService': 'Directory Service',
        'other': 'Not Defined'})}",
      name: "userLabel",
      args: [label],
      // locale: "en",
      desc: "User Identity labels",
      examples: const {"Name": "Name"}
  );
}

/// Specific messages and label for [UserAccess]
class UserAccessMsg {

  /// Label for user
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'SystemRole.superAdmin': 'Super Admin',
        'SystemRole.admin': 'Admin',
        'SystemRole.standard': 'Standard',
        'other': 'Not Defined'})}",
      name: "userAccessLabel",
      args: [label],
      // locale: "en",
      desc: "User Organization Access labels",
      examples: const {"Name": "Name"}
  );
}


/// Specific messages and label for [Work]
class WorkMsg {

  /// Label for work
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Works': 'Works',
        'Sorted By': 'Sorted By',
        'Edit Work': 'Edit Work',
        'Add Work': 'Add Work',
        'Objective': 'Objective',
        'Work Items Over Due': 'Work Items Over Due',
        'No Match': 'No Match',
        'Select': 'Select',
        'Filter Works': 'Filter Works',
        'other': 'Not Defined'})}",
      name: "workLabel",
      args: [label],
      // locale: "en",
      desc: "Work labels",
      examples: const {"Name": "Name"}
  );
}


/// Specific messages and label for [Stage]
class StageMsg {

  /// Label
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Work Stages': 'Work Stages',
        'Stage': 'Stage',
        'Select': 'Select',
        'other': 'Not Defined'})}",
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
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'State.notStarted': 'Not Started',
        'State.inProgress': 'In Progress',
        'State.completed': 'Completed',
        'other': 'Not Defined'})}",
      name: "stateLabel",
      args: [label],
      // locale: "en",
      desc: "State labels"
  );
}


/// Specific messages and label for [WorkItem]
class WorkItemMsg {

  /// Label for workitem
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Work Kanban': 'Work Kanban',
        'Work Items': 'Work Items',
        'Edit Work Item': 'Edit Work Item',
        'Add Work Item': 'Add Work Item',
        'Select a value': 'Select a value',
        'Work Items Over Due': 'Work Items Over Due',
        'Check Item': 'Check Item',
        'No Match': 'No Match',
        'Select a value': 'Select a value',
        'Drop File Here': 'Drop File Here',
        'other': 'Not Defined'})}",
      name: "workItemLabel",
      args: [label],
      // locale: "en",
      desc: "Work Item labels",
      examples: const {"Name": "Name"}
  );

  static valuePercentIntervalMsg() => Intl.message('The percentual value should be between 0 and 100');

}


/// Specific messages and label for [Objective]
class ObjectiveMsg {

  /// Label for work
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Objectives': 'Objectives',
        'Edit Objective': 'Edit Objective',
        'Add Objective': 'Add Objective',
        'Progress': 'Progress',
        'No Match': 'No Match',
        'Sorted By': 'Sorted By',
        'Ultimate Objective': 'Ultimate Objective',
        'other': 'Not Defined'})}",
      name: "objectiveLabel",
      args: [label],
      // locale: "en",
      desc: "Objective labels",
      examples: const {"Name": "Name"}
  );
}

/// Specific messages and label for [Map]
class MapMsg {

  /// Label for work
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Objectives Map': 'Objectives Map',
        'other': 'Not Defined'})}",
      name: "mapLabel",
      args: [label],
      // locale: "en",
      desc: "Map labels",
      examples: const {"Leader": "Leader"}
  );

  static notInformedMsg() => Intl.message("Not Informed!");
}

/// Specific messages and label for [Gantt]
class GanttMsg {

  /// Label for work
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Objectives Gantt': 'Objectives Gantt',
        'other': 'Not Defined'})}",
      name: "ganttLabel",
      args: [label],
      // locale: "en",
      desc: "Gantt labels",
      examples: const {"Group": "Group"}
  );
}

/// Specific messages and label for [Measure]
class MeasureMsg {

  /// Label for Measure
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Measures': 'Measures',
        'Edit Measure': 'Edit Measure',
        'Add Measure': 'Add Measure',
        'Progress': 'Progress',
        'other': 'Not Defined'})}",
      name: "measureLabel",
      args: [label],
      // locale: "en",
      desc: "Measure labels"
  );

  /// Label for Measure Unit
  static measureUnitLabel(String label) => Intl.message(
      "${Intl.select(label, {
        'Percent': 'Percent',
        'Money': 'Money',
        'Index': 'Index',
        'Unitary': 'Unitary'})}",
      name: "measureUnitLabel",
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

  /// Label for Measure
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Measure Progress': 'Measure Progress',
        'Progress Current Values': 'Progress Current Values',
        'other': 'Not Defined'})}",
      name: "measureProgressLabel",
      args: [label],
      // locale: "en",
      desc: "Measure Progresslabels"
  );

  static valueErrorMsg() => Intl.message("Current value should be between Start and End value.");
  static currentValueExistsAtDate() => Intl.message("Current value already exists at date informed.");
}




/// Specific messages and label for [ObjectiveHierarchy]
/*
class ObjectiveViewsMsg {

  /// Label for work
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Objectives Map': 'Objectives Map',
        'Objectives Gantt': 'Objectives Gantt',
        'other': 'Not Defined'})}",
      name: "objectiveMapLabel",
      args: [label],
      // locale: "en",
      desc: "Objective Map labels"
  );
}
*/

/// Specific messages and label for [Group]
class GroupMsg {

  /// Label for Group
  static label(String label) => Intl.message(
      "${Intl.select(label, {
        'Groups': 'Groups',
        'Edit Group': 'Edit Group',
        'Add Group': 'Add Group',
        'No Match': 'No Match',
        'Inactive': 'Inactive',
        'Inactive': 'Inactive',
        'other': 'Not Defined'})}",
      name: "groupLabel",
      args: [label],
      // locale: "en",
      desc: "Group labels",
  );

  /// Label for Group Type
  static groupTypeLabel(String label) => Intl.message(
      "${Intl.select(label, {
        'GroupType.company': 'Company',
        'GroupType.businessUnit': 'Business Unit',
        'GroupType.department': 'Department',
        'GroupType.team': 'Team',
        'other': 'Not Defined'})}",
      name: "groupTypeLabel",
      args: [label],
      // locale: "en",
      desc: "Group type labels"
  );
}

/// Specific messages and label for [Insight]
class InsightMsg {

  /// Label for Insight
  static label(String label) => Intl.message(
    "${Intl.select(label, {
      'Objectives Overall': 'Objectives Overall',
      'Objectives and Measures': 'Objectives and Measures',
      'Works and Work Items': 'Works and Work Items',
      'Objectives': 'Objectives',
      'Objectives Achieved': 'Objectives Achieved',
      'Objectives Requiring Attention': 'Objectives Requiring Attention',
      'Number total of objectives': 'Number total of objectives',
      'Objectives over 70% progress': 'Objectives over 70% progress',
      'Objectives below 30% progress': 'Objectives below 30% progress',

      'Measures': 'Measures',
      'Measures Achieved': 'Measures Achieved',
      'Measures Requiring Attention': 'Measures Requiring Attention',
      'Number total of measures': 'Number total of measures',
      'Measures over 70% progress': 'Measures over 70% progress',
      'Measures below 30% progress': 'Measures below 30% progress',

      'Works': 'Works',
      'Number total of Works': 'Number total of Works',
      'Works Completed': 'Works Completed',
      'Works Requiring Attention': 'Works Requiring Attention',
      'Works with 100% work items completed': 'Works with 100% work items completed',
      'Works with over due work items':'Works with over due work items',

      'Work Items': 'Work Items',
      'Work Items Completed': 'Work Items Completed',
      'Work Items Requiring Attention': 'Work Items Requiring Attention',
      'Number total of work items': 'Number total of work items',
      'Work items with 100% progress': 'Work items with 100% progress',
      'Over due work items': 'Over due work items',

      'other': 'Not Defined'})}",
    name: "insightLabel",
    args: [label],
    // locale: "en",
    desc: "Insight labels",
  );
}

/// Specific messages and label for [SystemFunction]
class SystemFunctionMsg {

  /// Label in past
  static inPastLabel(String functionName) => Intl.message(
    "${Intl.select(functionName, {
      'SystemFunction.create': 'Created',
      'SystemFunction.update': 'Updated',
      'SystemFunction.delete': 'Deleted',
      'SystemFunction.read': 'Read',
      'other': 'Not Defined'})}",
    name: "systemFunctionLabel",
    args: [functionName],
    // locale: "en",
    desc: "System Function labels",
  );
}


/// Specific messages and label for [SystemFunction]
class SystemModulenMsg {

  /// Label for Insight
  static label(String functionName) => Intl.message(
    "${Intl.select(functionName, {
      'SystemModule.create': 'Created',
      'SystemFunction.update': 'Updated',
      'SystemFunction.delete': 'Deleted',
      'SystemFunction.read': 'Read',
      'other': 'Not Defined'})}",
    name: "systemFunctionLabel",
    args: [functionName],
    // locale: "en",
    desc: "System Function labels",
  );
}

/// Specific messages and label for [TimelineItem] class field
class TimelineItemdMsg {

  /// Label for Insight
  static label(String fieldName) => Intl.message(
    "${Intl.select(fieldName, {
      'Timeline': 'Timeline',
      'day ago': 'day ago',
      'days ago': 'days ago',
      'hour ago': 'hour ago',
      'hours ago': 'hours ago',
      'minute ago': 'minutes ago',
      'minutes ago': 'minutes ago',
      'second ago': 'second ago',
      'seconds ago': 'seconds ago',
      'value': 'value',
      'the': 'the',
      'changed from': 'changed from',
      'was': 'was',
      'other': 'Not Defined'})}",
    name: "labelLabel",
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