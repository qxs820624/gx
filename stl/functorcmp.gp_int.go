///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Mon Jan 23 2017 10:03:43]
// Generate from:
//   [github.com/vipally/gx/stl/gp/functorcmp.gp]
//   [github.com/vipally/gx/stl/stl.gpg] [list_int]
//
// Tool [github.com/vipally/gogp] info:
// CopyRight 2016 @Ally Dale. All rights reserved.
// Author  : Ally Dale(vipally@gmail.com)
// Blog    : http://blog.csdn.net/vipally
// Site    : https://github.com/vipally
// BuildAt : [Oct  8 2016 10:34:35]
// Version : 3.0.0.final
//
///////////////////////////////////////////////////////////////////

//this file is used to import by other gp files
//it cannot use independently, simulation C++ stl functors

package stl

//cmp object, zero is Lesser
type CmpInt byte

const (
	CmpIntLesser  CmpInt = CMPLesser
	CmpIntGreater CmpInt = CMPGreater
)

//create cmp object by name
func CreateCmpInt(cmpName string) (r CmpInt) {
	r = CmpIntLesser.CreateByName(cmpName)
	return
}

//uniformed global function
func (me CmpInt) F(left, right int) (ok bool) {
	switch me {
	case CMPLesser:
		ok = me.less(left, right)
	case CMPGreater:
		ok = me.great(left, right)
	}
	return
}

//Lesser object
func (me CmpInt) Lesser() CmpInt { return CMPLesser }

//Greater object
func (me CmpInt) Greater() CmpInt { return CMPGreater }

//show as string
func (me CmpInt) String() (s string) {
	switch me {
	case CMPLesser:
		s = "Lesser"
	case CMPGreater:
		s = "Greater"
	default:
		s = "error cmp value"
	}
	return
}

//create by bool
func (me CmpInt) CreateByBool(bigFirst bool) (r CmpInt) {
	if bigFirst {
		r = CMPGreater
	} else {
		r = CMPLesser
	}
	return
}

//create cmp object by name
func (me CmpInt) CreateByName(cmpName string) (r CmpInt) {
	switch cmpName {
	case "": //default Lesser
		fallthrough
	case "Lesser":
		r = CMPLesser
	case "Greater":
		r = CMPGreater
	default: //unsupport name
		panic(cmpName)
	}
	return
}

//lesser operation
func (me CmpInt) less(left, right int) (ok bool) {

	ok = left < right

	return
}

//Greater operation
func (me CmpInt) great(left, right int) (ok bool) {

	ok = right < left

	return
}
