import 'package:intl/intl.dart';

import 'package:auge_server/model/general/user.dart';
import 'package:auge_server/model/general/user_identity.dart';
import 'package:auge_server/model/general/user_access.dart';
import 'package:auge_server/model/general/group.dart';
import 'package:auge_server/model/general/organization.dart';
import 'package:auge_server/model/general/organization_configuration.dart';
import 'package:auge_server/model/general/organization_directory_service.dart';
import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/work/work.dart';
import 'package:auge_server/model/work/work_stage.dart';
import 'package:auge_server/model/work/work_item.dart';


/// Specific messages and label for [User] class field
class CommonFieldAndValuesMsg {

  /// Label for Field User
  static labelAndValue(dynamic fieldName) => Intl.message(
    "${Intl.select(fieldName, {
      true: 'Yes',
      false: 'No',
      'other': 'Not Defined'})}",
    name: "commonFieldAndValuesLabel",
    args: [fieldName],
    // locale: "en",
    desc: "Common form field labels and values",
  );
}

class ClassNameMsg {

  /// Label for Field User
  static label(String className) => Intl.message(
    "${Intl.select(className, {
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
      'other': 'Not Defined'})}",
    name: "classNameLabel",
    args: [className],
    // locale: "en",
    desc: "Model class name labels",
  );
}

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

/// Specific messages and label for [UserProfile] model field and class
class UserProfileValueMsg {

  /// Static value for User
  static label(String valueName) => Intl.message(
    "${Intl.select(valueName, {
      'pt_BR': 'Português - Brasil',
      'en_US': 'English - USA',
      'es_ES': 'Espanhol - España',
      'other': 'Not Defined'})}",
    name: "userProfileFieldLabel",
    args: [valueName],
    // locale: "en",
    desc: "User Profile values labels",
  );
}