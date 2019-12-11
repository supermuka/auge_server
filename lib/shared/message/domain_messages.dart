import 'package:intl/intl.dart';

import 'package:auge_server/domain/general/user.dart';
import 'package:auge_server/domain/general/user_identity.dart';
import 'package:auge_server/domain/general/user_access.dart';
import 'package:auge_server/domain/general/group.dart';
import 'package:auge_server/domain/general/organization.dart';
import 'package:auge_server/domain/general/organization_configuration.dart';
import 'package:auge_server/domain/general/organization_directory_service.dart';
import 'package:auge_server/domain/objective/objective.dart';
import 'package:auge_server/domain/objective/measure.dart';
import 'package:auge_server/domain/work/work.dart';
import 'package:auge_server/domain/work/work_stage.dart';
import 'package:auge_server/domain/work/work_item.dart';

/// Specific messages and label for [User] class field

class CommonFieldAndValuesMsg {

  /// Label for Field User
  static labelAndValue(dynamic fieldName) => Intl.select(fieldName, {
      true: 'Yes',
      false: 'No',
      'other': 'Not Defined'},
    name: "CommonFieldAndValuesMsg_labelAndValue",
    args: [fieldName],
    // locale: "en",
    desc: "Common form field labels and values",
  );
}

class ClassNameMsg {

  /// Label for Field User
  static label(String className) => Intl.select(className, {
      User.className: 'User',
      UserProfile.className: 'User Profile',
      UserAccess.className: 'User and Profiles',
      Group.className: 'Group',
      Objective.className: 'Objective',
      Measure.className: 'Measure',
      MeasureProgress.className: 'Measure Progress',
      Work.className: 'Work',
      WorkStage.className: 'Stage',
      WorkItem.className: 'Work Item',
      'other': 'Not Defined'},
    name: "ClassNameMsg_label",
    args: [className],
    // locale: "en",
    desc: "Model class name labels",
  );
}

/// Specific messages and label for [User] class field
class UserDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {User.nameField: 'Name',
       User.inactiveField: 'Inactive',
       User.managedByOrganizationField: 'Managed By Organization'},
      name: 'UserDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [UserProfile] class field
class UserProfileDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {UserProfile.eMailField: 'e-Mail',
        UserProfile.eMailNotificationField: 'e-Mail Notification',
        UserProfile.imageField:'Image',
        UserProfile.idiomLocaleField:'Idioma'},
      name: 'UserProfileDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [UserIdentity] class field
class UserIdentityDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {UserIdentity.identificationField: 'Identification',
        UserIdentity.passwordField: 'Password',
        UserIdentity.providerField: 'Provider',
        UserIdentity.providerObjectIdField: 'Provider Object Id',},
      name: 'UserIdentityDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [UserAccess] class field
class UserAccessDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {UserAccess.organizationField:'Organization',
       UserAccess.accessRoleField:'Access Role',},
      name: 'UserAccessDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [Group] class field
class GroupDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {Group.nameField:'Name',
       Group.inactiveField:'Inactive',
       Group.leaderField:'Leader',
       Group.groupTypeField:'Group Type',
       Group.superGroupField:'Super Group',
       Group.leaderField: 'Leader',
       Group.membersField:'Members',},
      name: 'GroupDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [Objective] class field
class ObjectiveDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {Objective.nameField:'Name',
       Objective.descriptionField:'Description',
       Objective.groupField:'Group',
       Objective.alignedToField:'Aligned To',
       Objective.leaderField:'Leader',
       Objective.startDateField:'Start Date',
       Objective.endDateField:'End Date',
       Objective.archivedField:'Archived',},
      name: 'ObjectiveDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [MeasureUnit] class field
class MeasureUnitDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {MeasureUnit.nameField: 'Name',
       MeasureUnit.symbolField :'Symbol',},
      name: 'MeasureUnitDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [Measure] class field
class MeasureDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {Measure.nameField:'Name',
       Measure.descriptionField:'Description',
       Measure.endValueField:'End Value',
       Measure.startValueField:'Start Value',
       Measure.currentValueField:'Current Value',
       Measure.decimalsNumberField:'Decimals Number',
       Measure.measureUnitField:'Unit',
       Measure.metricField:'Metric'},
      name: 'MeasureDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [MeasureProgress] class field
class MeasureProgressDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {MeasureProgress.dateField:'Date',
      MeasureProgress.currentValueField:'Current Value',
      MeasureProgress.commentField:'Comment'},
      name: 'MeasureProgressDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [Organization] class field
class OrganizationDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
  {Organization.nameField:'Name',
   Organization.codeField:'EIN'},
  name: 'OrganizationDomainMsg_fieldLabel',
  args: [fieldName]);
}

/// Specific messages and label for [Work] class field
class WorkDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {Work.nameField:'Name',
       Work.descriptionField:'Description',
       Work.groupField:'Group',
       Work.leaderField:'Leader',
       Work.workStagesField:'Stages',
       Work.objectiveField:'Objective',},
      name: 'WorkDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [WorkStage] class field
class WorkStageDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {WorkStage.nameField:'Name',
       WorkStage.stateField:'State',},
      name: 'WorkStageDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [WorkItem] class field
class WorkItemDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {WorkItem.nameField:'Name',
       WorkItem.descriptionField:'Description',
       WorkItem.dueDateField:'Due Date',
       WorkItem.completedField:'Completed',
       WorkItem.workStageField:'Stage',
       WorkItem.assignedToField:'Assigned To',
       WorkItem.attachmentsField:'Attachments',
       WorkItem.checkItemsField:'Check Items',},
      name: 'WorkItemDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [OrganizationConfiguration] class field
class OrganizationConfigurationDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      {OrganizationConfiguration.domainField:'Domínio'},
      name: 'OrganizationConfigurationDomainMsg_fieldLabel',
      args: [fieldName]);
}

/// Specific messages and label for [OrganizationDirectoryService] class field
class OrganizationDirectoryServiceDomainMsg {
  static String fieldLabel(String fieldName) => Intl.select(fieldName,
      { OrganizationDirectoryService.directoryServiceEnabledField:'Directory Service (LDAP) Enabled',
        OrganizationDirectoryService.hostAddressField:'Host Address',
        OrganizationDirectoryService.portField:'Port',
        OrganizationDirectoryService.sslTlsField:'SSL/TLS Enabled',
        OrganizationDirectoryService.syncBindDnField:'Sync Bind DN',
        OrganizationDirectoryService.syncBindPasswordField:'Sync Bind Password (not saved)',

        OrganizationDirectoryService.groupSearchDNField:'Group Search DN',
        OrganizationDirectoryService.groupSearchScopeField:'Group Search Scope',
        OrganizationDirectoryService.groupSearchFilterField:'Group Search Filter',
        OrganizationDirectoryService.groupMemberUserAttributeField:'Group Member User Attribute',

        OrganizationDirectoryService.userSearchDNField:'User Search DN',
        OrganizationDirectoryService.userSearchScopeField:'User Search Scope',
        OrganizationDirectoryService.userSearchFilterField:'User Search Filter',
        OrganizationDirectoryService.userProviderObjectIdAttributeField:'User Provider Object Id (GUID/UUID) Attribute',
        OrganizationDirectoryService.userIdentificationAttributeField:'User Identification (login) Attribute',
        OrganizationDirectoryService.userFirstNameAttributeField:'User First Attribute',
        OrganizationDirectoryService.userLastNameAttributeField:'User Last Attribute',
        OrganizationDirectoryService.userEmailAttributeField:'User Email Attribute',
        OrganizationDirectoryService.userAttributeForGroupRelationshipField:'User Attribute for Group Relationship',
        OrganizationDirectoryService.syncIntervalField:'Sync Interval (hours)',
        OrganizationDirectoryService.syncLastDateTimeField:'Sync Last Date Time',
        OrganizationDirectoryService.syncLastResultField:'Sync Last Result',},
      name: 'OrganizationDirectoryServiceDomainMsg_fieldLabel',
      args: [fieldName]);
}

/*
/// Specific messages and label for [User] class field
class FieldMsg {

  /// Label for Field User
  static label(String classAndFieldName) => Intl.message(
    "${Intl.select(classAndFieldName, {
       //USER
      '${User.className}.${User.nameField}': 'Name',
      '${User.className}.${User.inactiveField}': 'Inactive',
      '${User.className}.${User.managedByOrganizationField}': 'Managed By Organization',

      //USERPROFILE
      '${UserProfile.className}.${UserProfile.eMailField}': 'e-Mail',
      '${UserProfile.className}.${UserProfile.eMailNotificationField}': 'e-Mail Notification',
      '${UserProfile.className}.${UserProfile.imageField}':'Image',
      '${UserProfile.className}.${UserProfile.idiomLocaleField}':'Idioma',

      //USERIDENTITY
      '${UserIdentity.className}.${UserIdentity.identificationField}': 'Identification',
      '${UserIdentity.className}.${UserIdentity.passwordField}': 'Password',
      '${UserIdentity.className}.${UserIdentity.providerField}': 'Provider',
      '${UserIdentity.className}.${UserIdentity.providerObjectIdField}': 'Provider Object Id',

      //USERORGANIZATIONACCESS
      '${UserAccess.className}.${UserAccess.organizationField}':'Organization',
      '${UserAccess.className}.${UserAccess.accessRoleField}':'Access Role',

      //GROUP
      '${Group.className}.${Group.nameField}':'Name',
      '${Group.className}.${Group.inactiveField}':'Inactive',
      '${Group.className}.${Group.leaderField}':'Leader',
      '${Group.className}.${Group.groupTypeField}':'Group Type',
      '${Group.className}.${Group.superGroupField}':'Super Group',
      '${Group.className}.${Group.leaderField}':'Leader',
      '${Group.className}.${Group.membersField}':'Members',
      
      //OBJECTIVE
      '${Objective.className}.${Objective.nameField}':'Name',
      '${Objective.className}.${Objective.descriptionField}':'Description',
      '${Objective.className}.${Objective.groupField}':'Group',
      '${Objective.className}.${Objective.alignedToField}':'Aligned To',
      '${Objective.className}.${Objective.leaderField}':'Leader',
      '${Objective.className}.${Objective.startDateField}':'Start Date',
      '${Objective.className}.${Objective.endDateField}':'End Date',
      '${Objective.className}.${Objective.archivedField}':'Archived',
      
      //MEASURE
      '${Measure.className}.${Measure.nameField}':'Name',
      '${Measure.className}.${Measure.descriptionField}':'Description',
      '${Measure.className}.${Measure.endValueField}':'End Value',
      '${Measure.className}.${Measure.startValueField}':'Start Value',
      '${Measure.className}.${Measure.currentValueField}':'Current Value',
      '${Measure.className}.${Measure.decimalsNumberField}':'Decimals Number',
      '${Measure.className}.${Measure.measureUnitField}':'Unit',
      '${Measure.className}.${Measure.metricField}':'Metric',
      
      //MEASURE PROGRESS
      '${MeasureProgress.className}.${MeasureProgress.dateField}':'Date',
      '${MeasureProgress.className}.${MeasureProgress.currentValueField}':'Current Value',
      '${MeasureProgress.className}.${MeasureProgress.commentField}':'Comment',
      
      //ORGANIZATION
      '${Organization.className}.${Organization.nameField}':'Name',
      '${Organization.className}.${Organization.codeField}':'EIN',
      
      //INITIATIVE
      '${Work.className}.${Work.nameField}':'Name',
      '${Work.className}.${Work.descriptionField}':'Description',
      '${Work.className}.${Work.groupField}':'Group',
      '${Work.className}.${Work.leaderField}':'Leader',
      '${Work.className}.${Work.workStagesField}':'Stages',
      '${Work.className}.${Work.objectiveField}':'Objective',
      
      //STAGE
      '${WorkStage.className}.${WorkStage.nameField}':'Name',
      '${WorkStage.className}.${WorkStage.stateField}':'State',
      
      //WORK ITEMS
      '${WorkItem.className}.${WorkItem.nameField}':'Name',
      '${WorkItem.className}.${WorkItem.descriptionField}':'Description',
      '${WorkItem.className}.${WorkItem.dueDateField}':'Due Date',
      '${WorkItem.className}.${WorkItem.completedField}':'Completed',
      '${WorkItem.className}.${WorkItem.workStageField}':'Stage',
      '${WorkItem.className}.${WorkItem.assignedToField}':'Assigned To',
      '${WorkItem.className}.${WorkItem.attachmentsField}':'Attachments',
      '${WorkItem.className}.${WorkItem.checkItemsField}':'Check Items',
      
      //CONFIGURATION
      '${OrganizationConfiguration.className}.${OrganizationConfiguration.domainField}':'Domínio',

      //DIRECTORY SERVICE CONFIGURATION
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.directoryServiceEnabledField}':'Directory Service (LDAP) Enabled',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.hostAddressField}':'Host Address',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.portField}':'Port',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.sslTlsField}':'SSL/TLS Enabled',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.syncBindDnField}':'Sync Bind DN',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.syncBindPasswordField}':'Sync Bind Password (not saved)',

      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.groupSearchDNField}':'Group Search DN',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.groupSearchScopeField}':'Group Search Scope',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.groupSearchFilterField}':'Group Search Filter',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.groupMemberUserAttributeField}':'Group Member User Attribute',

      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userSearchDNField}':'User Search DN',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userSearchScopeField}':'User Search Scope',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userSearchFilterField}':'User Search Filter',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userProviderObjectIdAttributeField}':'User Provider Object Id (GUID/UUID) Attribute',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userIdentificationAttributeField}':'User Identification (login) Attribute',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userFirstNameAttributeField}':'User First Attribute',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userLastNameAttributeField}':'User Last Attribute',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userEmailAttributeField}':'User Email Attribute',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.userAttributeForGroupRelationshipField}':'User Attribute for Group Relationship',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.syncIntervalField}':'Sync Interval (hours)',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.syncLastDateTimeField}':'Sync Last Date Time',
      '${OrganizationDirectoryService.className}.${OrganizationDirectoryService.syncLastResultField}':'Sync Last Result',

      'other': 'Not Defined'})}",
    name: "FieldLabel",
    args: [classAndFieldName],
    // locale: "en",
    desc: "User form field labels",
  );
}
*/
/// Specific messages and label for [UserProfile] model field and class
class UserProfileValueMsg {

  /// Static value for User
  static label(String valueName) => Intl.select(valueName, {
      'pt_BR': 'Português - Brasil',
      'en_US': 'English - USA',
      'es_ES': 'Espanhol - España',
      'other': 'Not Defined'},
    name: "UserProfileValueMsg_label",
    args: [valueName],
    // locale: "en",
    desc: "User Profile values labels",
  );
}

