//#GOGP_IGNORE_BEGIN
///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Mon Oct 31 2016 22:32:17]
// Generate from:
//   [github.com/vipally/gx/stl/gp/functorcmp.go]
//   [github.com/vipally/gx/stl/gp/gp.gpg] [GOGP_REVERSE_functorcmp]
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
//#GOGP_IGNORE_END

//this file is used to import by other gp files
//it cannot use independently, simulation C++ stl functors
<PACKAGE>

//#GOGP_REQUIRE(github.com/vipally/gx/stl/gp/fakedef,_)

//#GOGP_ONCE
const (
	CMPLesser = iota //default
	CMPGreater
) //
//#GOGP_ONCE_END

//cmp object, zero is Lesser
type Cmp<GLOBAL_NAME_PART> byte

const (
	Cmp<GLOBAL_NAME_PART>Lesser  Cmp<GLOBAL_NAME_PART> = CMPLesser
	Cmp<GLOBAL_NAME_PART>Greater Cmp<GLOBAL_NAME_PART> = CMPGreater
)

//create cmp object by name
func CreateCmp<GLOBAL_NAME_PART>(cmpName string) (r Cmp<GLOBAL_NAME_PART>) {
	r = Cmp<GLOBAL_NAME_PART>Lesser.CreateByName(cmpName)
	return
}

//uniformed global function
func (me Cmp<GLOBAL_NAME_PART>) F(left, right <VALUE_TYPE>) (ok bool) {
	switch me {
	case CMPLesser:
		ok = me.less(left, right)
	case CMPGreater:
		ok = me.great(left, right)
	}
	return
}

func (me Cmp<GLOBAL_NAME_PART>) Lesser() Cmp<GLOBAL_NAME_PART>  { return CMPLesser }
func (me Cmp<GLOBAL_NAME_PART>) Greater() Cmp<GLOBAL_NAME_PART> { return CMPGreater }

func (me Cmp<GLOBAL_NAME_PART>) String() (s string) {
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

func (me Cmp<GLOBAL_NAME_PART>) CreateByName(cmpName string) (r Cmp<GLOBAL_NAME_PART>) {
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

func (me Cmp<GLOBAL_NAME_PART>) less(left, right <VALUE_TYPE>) (ok bool) {
	//#GOGP_IFDEF GOGP_HasCmpFunc
	ok = left.Less(right)
	//#GOGP_ELSE
	ok = left < right
	//#GOGP_ENDIF
	return
}
func (me Cmp<GLOBAL_NAME_PART>) great(left, right <VALUE_TYPE>) (ok bool) {
	//#GOGP_IFDEF GOGP_HasCmpFunc
	ok = right.Less(left)
	//#GOGP_ELSE
	ok = right < left
	//#GOGP_ENDIF
	return
}

////////////////////////////////////////////////////////////////////////////////
//type Comparer<GLOBAL_NAME_PART> interface {
//	F(left, right <VALUE_TYPE>) bool
//}

////create cmp object by name
//func CreateComparer<GLOBAL_NAME_PART>(cmpName string) (r Comparer<GLOBAL_NAME_PART>) {
//	switch cmpName {
//	case "": //default Lesser
//		fallthrough
//	case "Lesser":
//		r = Lesser<GLOBAL_NAME_PART>{}
//	case "Greater":
//		r = Greater<GLOBAL_NAME_PART>{}
//	default: //unsupport name
//		panic(cmpName)
//	}
//	return
//}

////Lesser
//type Lesser<GLOBAL_NAME_PART> struct{}

//func (this Lesser<GLOBAL_NAME_PART>) F(left, right <VALUE_TYPE>) (ok bool) {
//	//#GOGP_IFDEF GOGP_HasCmpFunc
//	ok = left.Less(right)
//	//#GOGP_ELSE
//	ok = left < right
//	//#GOGP_ENDIF
//	return
//}

////Greater
//type Greater<GLOBAL_NAME_PART> struct{}

//func (this Greater<GLOBAL_NAME_PART>) F(left, right <VALUE_TYPE>) (ok bool) {
//	//#GOGP_IFDEF GOGP_HasCmpFunc
//	ok = right.Less(left)
//	//#GOGP_ELSE
//	ok = left > right
//	//#GOGP_ENDIF
//	return
//}

