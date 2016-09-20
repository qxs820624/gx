// This file was auto-generated by [gogp] tool
// Last modify at: [Tue Sep 20 2016 23:06:17]
// !!!!!!!!!NEVER MODIFY IT MANUALLY!!!!!!!!!

//    CopyRight @Ally Dale 2016
//    Author  : Ally Dale(vipally@gmail.com)
//    Blog    : http://blog.csdn.net/vipally
//    Site    : https://github.com/vipally
//    BuildAt : [Sep 20 2016 22:10:12]
//    Version : 1.0.2


package regable

import (
	"bytes"
	"fmt"
	"sync"
	acst "vipally.gmail.com/basic/consts"
	aerr "vipally.gmail.com/basic/errors"
	amath "vipally.gmail.com/basic/math"
)

const (
	default_str_reg_cnt = 1024
)

var (
	g_str_rgr_id_gen, _         = amath.NewRangeUint32(g_invalid_id+1, g_invalid_id, g_max_reger_id)
	errid_str_id, _  = aerr.Reg("StringId error")
	errid_str_obj, _ = aerr.Reg("String object error")
)

var (
	g_str_reger_list []*StringReger
)

func init() {
	reg_show(ShowAllStringRegers)
}

//new reger
func NewStringReger(name string) (r *StringReger, err error) {
	defer func() {
		if err != nil {
			panic(err)
		}
	}()
	if err = check_lock(); err != nil {
		return
	}
	id := g_invalid_id
	if id, err = g_str_rgr_id_gen.Inc(); err != nil {
		return
	}
	p := new(StringReger)
	if err = p.init(name); err == nil {
		p.reger_id = uint8(id)
		r = p
		g_str_reger_list = append(g_str_reger_list, p)
	}
	return
}

func MustNewStringReger(name string) (r *StringReger) {
	if reg, err := NewStringReger(name); err != nil {
		panic(err)
	} else {
		r = reg
	}
	return
}

//show all regers
func ShowAllStringRegers() string {
	var buf bytes.Buffer
	s := fmt.Sprintf("[StringRegers] count:%d", len(g_str_reger_list))
	buf.WriteString(s)
	for _, v := range g_str_reger_list {
		buf.WriteString(acst.NEW_LINE)
		buf.WriteString(v.String())
	}
	return buf.String()
}

//reger object
type StringReger struct {
	reger_id uint8
	name     string
	id_gen   amath.RangeUint32
	reg_list []*_stringRecord
}

func (me *StringReger) init(name string) (err error) {
	me.name = name
	if err = me.id_gen.Init(g_invalid_id+1, g_invalid_id,
		g_invalid_id+default_str_reg_cnt); err != nil {
		return
	}
	me.reg_list = make([]*_stringRecord, 0, 0)
	return
}

//set max reg count at a reger
func (me *StringReger) MaxReg(max_regs uint32) (rmax uint32, err error) {
	if err = verify_max_regs(max_regs); err != nil {
		return
	}
	cur, min, _ := me.id_gen.Get()
	if err = me.id_gen.Init(cur, min, g_invalid_id+max_regs); err != nil {
		return
	}
	rmax = me.id_gen.Max()
	return
}

//reg a value
func (me *StringReger) Reg(/*name string,*/ val string) (r StringId, err error) {
	r = StringId(g_invalid_id)
	defer func() {
		if err != nil {
			panic(err)
		}
	}()
	id := g_invalid_id
	if err = check_lock(); err != nil {
		return
	}
	if id, err = me.id_gen.Inc(); err != nil {
		return
	}
	p := me.new_rec(/*name,*/ val)
	p.id = id
	me.reg_list = append(me.reg_list, p)
	r = StringId(MakeRegedId(uint32(me.reger_id), id))
	return
}

func (me *StringReger) MustReg(/*name string,*/ val string) (r StringId) {
	if reg, err := me.Reg(/*name,*/ val); err != nil {
		panic(err)
	} else {
		r = reg
	}
	return
}

//show string
func (me *StringReger) String() string {
	var buf bytes.Buffer
	s := fmt.Sprintf("[StringReger#%d: %s] ids:%s",
		me.reger_id, me.name, me.id_gen.String())
	buf.WriteString(s)
	for i, v := range me.reg_list {
		v.lock.RLock()
		s = fmt.Sprintf("\n#%d [%s]: %v",
			uint32(i)+g_invalid_id+1, ""/*v.name*/,
			v.val)
		v.lock.RUnlock()
		buf.WriteString(s)
	}
	return buf.String()
}

type _stringRecord struct {
	/*name string*/
	val  string
	id   uint32
	lock sync.RWMutex
}

func (me *StringReger) new_rec(/*name string,*/ val string) (r *_stringRecord) {
	r = new(_stringRecord)
	/*r.name = name*/
	r.val = val
	return
}

type StringId regedId

func (cp StringId) get() (rg *StringReger, r *_stringRecord, err error) {
	idrgr, id := regedId(cp).ids()
	idregidx, idx := idrgr-g_invalid_id-1, id-g_invalid_id-1
	if idrgr == g_invalid_id || !g_str_rgr_id_gen.InCurrentRange(idrgr) {
		err = aerr.New(errid_str_id)
	}
	rg = g_str_reger_list[idregidx]
	if id == g_invalid_id || !rg.id_gen.InCurrentRange(id) {
		err = aerr.New(errid_str_id)
	}
	r = rg.reg_list[idx]
	return
}

//check if valid
func (cp StringId) Valid() (rvalid bool) {
	if _, _, e := cp.get(); e == nil {
		rvalid = true
	}
	return
}

//get value
func (cp StringId) Get() (r string, err error) {
	_, rc, e := cp.get()
	if e != nil {
		return r, e
	}
	return rc.Get()
}

//get value with out error, if has error will cause panic
func (cp StringId) GetNoErr() (r string) {
	_, rc, e := cp.get()
	if e != nil {
		panic(e.Error())
	}
	return rc.GetNoErr()
}

//set value
func (cp StringId) Set(val string) (r string, err error) {
	_, rc, e := cp.get()
	if e != nil {
		return r, e
	}
	return rc.Set(val)
}

//reverse bool value(as a switch)
//func (cp StringId) Reverse() (r string, err error) {
//	_, rc, e := cp.get()
//	if e != nil {
//		return r, e
//	}
//	return rc.Reverse()
//}

//get reger_id and real_id
func (cp StringId) Ids() (reger_id, real_id uint32) {
	return regedId(cp).ids()
}

//show string
func (cp StringId) String() (r string) {
	idrgr, id := regedId(cp).ids()
	_, rc, err := cp.get()
	if err != nil {
		r = fmt.Sprintf("invalid StringId#(%d|%d)", idrgr, id)
	} else {
		r = rc.String()
	}
	return
}

//get name
/*
func (cp StringId) Name() (r string, err error) {
	_, rc, e := cp.get()
	if e == nil {
		r, err = rc.Name()
	} else {
		err = e
	}
	return
}
*/

//get as object for fast access
func (cp StringId) Oject() (r StringObj) {
	_, rc, e := cp.get()
	if e == nil {
		r.obj = rc
	}
	return
}

//get name
/*
func (me *_stringRecord) Name() (r string, err error) {
	if me != nil {
		me.lock.RLock()
		defer me.lock.RUnlock()
		r = me.name
	} else {
		err = aerr.New(errid_str_obj)
	}
	return
}
*/

//get value
func (me *_stringRecord) Get() (r string, err error) {
	if me != nil {
		me.lock.RLock()
		defer me.lock.RUnlock()
		r = me.val
	} else {
		err = aerr.New(errid_str_obj)
	}
	return
}

//get value without error,if has error will cause panic
func (me *_stringRecord) GetNoErr() (r string) {
	r0, err := me.Get()
	if err != nil {
		panic(err.Error())
	}
	r = r0
	return
}

//set value
func (me *_stringRecord) Set(val string) (r string, err error) {
	if nil != me {
		me.lock.Lock()
		defer me.lock.Unlock()
		me.val = val
		r = val
	} else {
		err = aerr.New(errid_str_obj)
	}
	return
}

//reverse on bool value
//func (me *_stringRecord) Reverse() (r string, err error) {
//	if nil != me {
//		me.lock.Lock()
//		defer me.lock.Unlock()
//		me.val = !me.val
//		r = me.val
//	} else {
//		err = aerr.New(errid_str_obj)
//	}
//	return
//}

//get as Id
func (me *_stringRecord) Id() (r StringId) {
	if me != nil {
		r = StringId(me.id)
	}
	return
}

//show string
func (me *_stringRecord) String() (r string) {
	if me != nil {
		idrgr, id := regedId(me.id).ids()
		me.lock.RLock()
		defer me.lock.RUnlock()
		r = fmt.Sprintf("String#(%d|%d|%s)%v", idrgr, id, ""/*me.name*/, me.val)
	} else {
		r = fmt.Sprintf("invalid string object")
	}
	return
}

//object of reged value,it is more efficient to access than Id object
type StringObj struct {
	obj *_stringRecord
}

//check if valid
func (cp StringObj) Valid() (rvalid bool) {
	return cp.obj != nil
}

//get value
func (cp StringObj) Get() (r string, err error) {
	return cp.obj.Get()
}

//get value against error,if has error will cause panic
func (cp StringObj) GetNoErr() (r string) {
	return cp.obj.GetNoErr()
}

//set value
func (cp StringObj) Set(val string) (r string, err error) {
	return cp.obj.Set(val)
}

//reverse bool object
//func (cp StringObj) Reverse() (r string, err error) {
//	return cp.obj.Reverse()
//}

//show string
func (cp StringObj) String() (r string) {
	return cp.obj.String()
}

//get name
/*
func (cp StringObj) Name() (r string, err error) {
	return cp.obj.Name()
}
*/

//get as Id
func (cp StringObj) Id() (r StringId) {
	return cp.obj.Id()
}

//reg and return an object agent
func (me *StringReger) RegO(/*name string,*/ val string) (r StringObj, err error) {
	id, e := me.Reg(/*name,*/ val)
	if e == nil {
		r = id.Oject()
	} else {
		err = e
	}
	return
}

func (me *StringReger) MustRegO(/*name string,*/ val string) (r StringObj) {
	if reg, err := me.RegO(/*name,*/ val); err != nil {
		panic(err)
	} else {
		r = reg
	}
	return
}
