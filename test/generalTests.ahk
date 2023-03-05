


Global _testConsole := new Console("Test", "  ")

class TestObject {
	__New() {
		this.numx := 4
		this.numy := 8
		this.numz := 16
		this.obj := {a: 1, b: 2, c: 3, d: {e: 4, f: 5, g: 6}}

		this.zarr := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	}
}

global typeTest := ["a", 123, 1.8, true, [1,2], {a: 1, b: 2, c: 3}]
global arrTest := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
global objTest := {a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10}

global floatTest := 12.21

Global testObj := new TestObject()

StartTest() {
	; TestConsole()
	; for i in StringCharacterArray {
	; 	OutputDebug, % StringCharacterArray[i] "`n"
	; }
	; OutputDebug, % arrTest.indexOf("c") "`n"
	; OutputDebug, % arrTest.join("|") "`n"
	; for i in arrTest {
	; 	OutputDebug, % "Type of: " arrTest[i] " = " arrTest.type() "`n"
	; 	OutputDebug, % arrTest.type()
	; }
}

TestConsole() {
	_testConsole.log("Testing!!")
	_testConsole.log(new TestObject())
	_testConsole.log([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
	_testConsole.log(Object.keys(testObj))
	_testConsole.log(Object.values(testObj))
}

BaseTypeTest() {
	; OutputDebug, % "[String]: "  isObj("arrTest") "`n"
	; OutputDebug, % "[Obj String]: " isObj("String") "`n"
	; OutputDebug, % "[Int]: "  isObj(12) "`n"
	; OutputDebug, % "[Float]: " isObj(float) "`n"
	; OutputDebug, % "[Array]: " isObj(arrTest) "`n"
	; OutputDebug, % "[Object]: " isObj(objTest) "`n"
	; OutputDebug, % "[Class]: " isObj(testObj) "`n"
	; OutputDebug, % "[obj Object]: " isObj(objTest) "`n"
	; OutputDebug, % "[obj Class]: " isObj(testObj) "`n`n"
	
	; OutputDebug, % "[String]: "  "arrTest".isObject() "`n"
	; OutputDebug, % "[Obj String]: " Object.isObj("String") "`n"
	; OutputDebug, % "[Int]: "  12.isObject(12) "`n"
	; OutputDebug, % "[Float]: " float.isObject(float) "`n"
	; OutputDebug, % "[Array]: " arrTest.isObject(arrTest) "`n"
	; OutputDebug, % "[Object]: " objTest.isObject(objTest) "`n"
	; OutputDebug, % "[Class]: " testObj.isObject(testObj) "`n"
	; OutputDebug, % "[obj Object]: " objTest.isObject() "`n"
	; OutputDebug, % "[obj Class]: " testObj.isObject() "`n"

	; OutputDebug, % "`nArray: " arrTest.isArray() "`n"
	; OutputDebug, % "String: " "arrTest".isArray() "`n"
	; OutputDebug, % "Class: " testObj.isArray() "`n"
	; OutputDebug, % "Object: " objTest.isArray() "`n`n"
}
