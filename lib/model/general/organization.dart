// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

// Proto buffer transport layer.
import 'package:auge_server/src/protos/generated/general/organization.pb.dart' as organization_pb;

/// Domain model class to represent an organiozation (corporate, team, etc.)
class Organization {

  // Base fields
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  /// Specific fields
  static final String nameField = 'name';
  String name;

  /// i.e. CNPJ (Brazil), EIN (USA)
  static final String codeField = 'code';
  String code;

  organization_pb.Organization writeToProtoBuf() {
    organization_pb.Organization organizatoinPb = organization_pb.Organization();

    if (this.id != null) organizatoinPb.id = this.id;
    if (this.version != null) organizatoinPb.version = this.version;
    if (this.name != null) organizatoinPb.name = this.name;
    if (this.code != null) organizatoinPb.code = this.code;

    return organizatoinPb;
  }

  readFromProtoBuf(organization_pb.Organization organizationPb) {
    if (organizationPb.hasId()) this.id = organizationPb.id;
    if (organizationPb.hasVersion()) this.version = organizationPb.version;
    if (organizationPb.hasName()) this.name = organizationPb.name;
    if (organizationPb.hasCode()) this.code = organizationPb.code;

  }

}