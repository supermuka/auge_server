import 'dart:mirrors';
import 'package:test/test.dart';

import 'package:auge_shared/domain/general/group.dart';

void main() {

  group('Consts to Class and Field.', () {

    setUp(() {
    });

    tearDown(() async {});

    group('Group.', () {
      test('Group entity.', () async {
        ClassMirror classMirror = reflectClass(Group);
       // im.type.staticMembers.values.forEach((MethodMirror method) => print(method.simpleName));

        // classMirror.typeVariables.forEach((f) => print(f.qualifiedName));


        classMirror.declarations.values.forEach((DeclarationMirror declaration) {
          if (declaration is VariableMirror) {
            print( declaration.type );
          }

        });
    });
    });
  });
}


/*
import 'dart:mirrors';
import 'dart:io';


main() {
  var im = reflect(File('test.dart') ); // Retrieve the InstanceMirror of some class instance.
  im.type.instanceMembers.values.forEach((MethodMirror method) => print(method.simpleName));
}
*/

/*
import 'dart:mirrors';


class A {

}

main() {
  TypeMirror typeOfA = reflectType(A);
  // or reflectType(a.runtimeType) if a is an instance of A

  // getting metadata of the class
  List<InstanceMirror> metadatas = typeOfA.metadata;
  for (InstanceMirror m in metadatas) {
    ClassMirror cm = m.type;
    // here you get the Class of the annotation
    print(cm.simpleName);
  }
}
*/

/*
import 'dart:mirrors';

void main() {
  MyClass myClass = new MyClass();
  InstanceMirror im = reflect(myClass);
  ClassMirror classMirror = im.type;

  print('** classMirror.metadata');
  classMirror.metadata.forEach((metadata) {
    if (metadata.reflectee is Todo) {
      print(metadata.reflectee.name);
      print(metadata.reflectee.description);
    }
  });

  print('** classMirror.declarations');
  for (var v in classMirror.declarations.values) {
    if (!v.metadata.isEmpty) {
      if (v.metadata.first.reflectee is Todo) {
        print(v.metadata.first.reflectee.name);
        print(v.metadata.first.reflectee.description);
      }
    }
  }
}

class Todo {
  final String name;
  final String description;

  const Todo(this.name, this.description);
}

@Todo('Chibi', 'Rename class')
class MyClass{

  @Todo('Tuwaise', 'Change fielld type')
  int value;

  @Todo('Anyone', 'Change format')
  void printValue() {
    print('value: $value');
  }

  @Todo('Anyone', 'Remove this')
  MyClass();
}
 */