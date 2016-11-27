///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Sun Nov 27 2016 22:16:09]
// Generate from:
//   [github.com/vipally/gx/stl/gp/functorcmp.gp]
//   [github.com/vipally/gx/stl/stl.gpg] [_tree_sort_slice_int]
//
// Tool [github.com/vipally/gogp] info:
// CopyRight 2016 @Ally Dale. All rights reserved.
// Author  : Ally Dale(vipally@gmail.com)
// Blog    : http://blog.csdn.net/vipally
// Site    : https://github.com/vipally
// BuildAt : [Oct 24 2016 20:25:45]
// Version : 3.0.0.final
//
///////////////////////////////////////////////////////////////////

//this file is used to import by other gp files
//it cannot use independently, simulation C++ stl functors

package stl

//cmp object, zero is Lesser
type CmpIntTreeNode byte

const (
	CmpIntTreeNodeLesser  CmpIntTreeNode = CMPLesser
	CmpIntTreeNodeGreater CmpIntTreeNode = CMPGreater
)

//create cmp object by name
func CreateCmpIntTreeNode(cmpName string) (r CmpIntTreeNode) {
	r = CmpIntTreeNodeLesser.CreateByName(cmpName)
	return
}

//uniformed global function
func (me CmpIntTreeNode) F(left, right *IntTreeNode) (ok bool) {
	switch me {
	case CMPLesser:
		ok = me.less(left, right)
	case CMPGreater:
		ok = me.great(left, right)
	}
	return
}

//Lesser object
func (me CmpIntTreeNode) Lesser() CmpIntTreeNode { return CMPLesser }

//Greater object
func (me CmpIntTreeNode) Greater() CmpIntTreeNode { return CMPGreater }

//show as string
func (me CmpIntTreeNode) String() (s string) {
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
func (me CmpIntTreeNode) CreateByBool(bigFirst bool) (r CmpIntTreeNode) {
	if bigFirst {
		r = CMPGreater
	} else {
		r = CMPLesser
	}
	return
}

//create cmp object by name
func (me CmpIntTreeNode) CreateByName(cmpName string) (r CmpIntTreeNode) {
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
func (me CmpIntTreeNode) less(left, right *IntTreeNode) (ok bool) {

	ok = left.Less(right)

	return
}

//Greater operation
func (me CmpIntTreeNode) great(left, right *IntTreeNode) (ok bool) {

	ok = right.Less(left)

	return
}
