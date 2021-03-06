//#GOGP_IGNORE_BEGIN
///////////////////////////////////////////////////////////////////
//
// !!!!!!!!!!!! NEVER MODIFY THIS FILE MANUALLY !!!!!!!!!!!!
//
// This file was auto-generated by tool [github.com/vipally/gogp]
// Last update at: [Mon Jan 23 2017 10:01:57]
// Generate from:
//   [github.com/vipally/gx/stl/gp/rbtree.gp.go]
//   [github.com/vipally/gx/stl/gp/gp.gpg] [GOGP_REVERSE_rbtree]
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
//#GOGP_IGNORE_END

//rb-tree

<PACKAGE>

//#GOGP_REQUIRE(github.com/vipally/gogp/lib/fakedef,_)

//#GOGP_REQUIRE(github.com/vipally/gx/stl/gp/functorcmp)

////////////////////////////////////////////////////////////////////////////////

//var g<GLOBAL_NAME_PREFIX>RBTreeGbl struct {
//	cmp Cmp<GLOBAL_NAME_PREFIX>
//}

//func init() {
//	g<GLOBAL_NAME_PREFIX>RBTreeGbl.cmp = g<GLOBAL_NAME_PREFIX>RBTreeGbl.cmp.CreateByName("#GOGP_GPGCFG(GOGP_DefaultCmpType)")
//}

//#GOGP_ONCE
type ColorType int8

const (
	RBTREE_RED ColorType = iota //default
	RBTREE_BLACK
) //
//#GOGP_END_ONCE

type <GLOBAL_NAME_PREFIX>RBTree struct {
	header <GLOBAL_NAME_PREFIX>RBTreeNode
	size   int
	cmp    Cmp<GLOBAL_NAME_PREFIX>
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) createNode(d <GLOBAL_NAME_PREFIX>RBTreeNodeData) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	r := &<GLOBAL_NAME_PREFIX>RBTreeNode{}
	r.val = d
	return r
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) root() *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return this.header.parent
}
func (this *<GLOBAL_NAME_PREFIX>RBTree) topLeft() *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return this.header.left
}
func (this *<GLOBAL_NAME_PREFIX>RBTree) topRight() *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return this.header.right
}

type <GLOBAL_NAME_PREFIX>RBTreeNodeData struct {
	key <KEY_TYPE>
	//#GOGP_IFDEF VALUE_TYPE
	val <VALUE_TYPE>
	//#GOGP_ENDIF
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNodeData) Key() <KEY_TYPE> {
	return this.key
}

//#GOGP_IFDEF VALUE_TYPE
func (this *<GLOBAL_NAME_PREFIX>RBTreeNodeData) Value() <VALUE_TYPE> {
	return this.val
} //
//#GOGP_ENDIF

//tree node
type <GLOBAL_NAME_PREFIX>RBTreeNode struct {
	val                 <GLOBAL_NAME_PREFIX>RBTreeNodeData
	left, right, parent *<GLOBAL_NAME_PREFIX>RBTreeNode
	color               ColorType
}

//func (this *<GLOBAL_NAME_PREFIX>RBTree) Root() *<GLOBAL_NAME_PREFIX>RBTreeNode { return this.root() }

func (this *<GLOBAL_NAME_PREFIX>RBTreeNode) Get() *<GLOBAL_NAME_PREFIX>RBTreeNodeData {
	return &this.val
}

type <GLOBAL_NAME_PREFIX>RBTreeNodeVisitor struct {
	node, root *<GLOBAL_NAME_PREFIX>RBTreeNode
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNodeVisitor) Next() bool {
	return false
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNodeVisitor) Prev() bool {
	return false
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNodeVisitor) Get() *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return this.node
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNode) rebalence(root **<GLOBAL_NAME_PREFIX>RBTreeNode) {
	if this != nil && *root == this {
		this.color = RBTREE_RED
	}
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNode) topLeft() (n *<GLOBAL_NAME_PREFIX>RBTreeNode) {
	if this != nil {
		for n = this; n.left != nil; n = n.left { //body do nothing
		}
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNode) topRight() (n *<GLOBAL_NAME_PREFIX>RBTreeNode) {
	if this != nil {
		for n = this; n.right != nil; n = n.right { //body do nothing
		}
	}
	return
}

//next node
func (this *<GLOBAL_NAME_PREFIX>RBTreeNode) next() (n *<GLOBAL_NAME_PREFIX>RBTreeNode) {
	if this != nil {
		if this.right != nil {
			n = this.right.topLeft()
		} else {
			x, y := this, this.parent
			for x == y.right {
				x, y = y, y.parent
			}
			if x.right != y { //x is not header
				x = y
			}
			n = x
		}
	}
	return
}

//prev node
func (this *<GLOBAL_NAME_PREFIX>RBTreeNode) prev() (n *<GLOBAL_NAME_PREFIX>RBTreeNode) {
	if this != nil {
		if this.color == RBTREE_RED && this.parent == this { //this is header
			n = this.right
		} else if this.left != nil {
			n = this.left.topRight()
		} else {
			x, y := this, this.parent
			for x == y.left {
				x, y = y, y.parent
			}
			n = y
		}
	}
	return
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNode) rotateLeft(root **<GLOBAL_NAME_PREFIX>RBTreeNode) {
	if this != nil && *root == this {
		y := this.right
		if this.right = y.left; y.left != nil {
			y.left.parent = this
		}
		y.parent = this.parent
		*root = y
		y.left = this
		this.parent = y
	}
}

func (this *<GLOBAL_NAME_PREFIX>RBTreeNode) rotateRight(root **<GLOBAL_NAME_PREFIX>RBTreeNode) {
	if this != nil && *root == this {
		y := this.left
		if this.left = y.right; y.right != nil {
			y.right.parent = this
		}
		y.parent = this.parent
		*root = y
		y.right = this
		this.parent = y
	}
}

//new object
func New<GLOBAL_NAME_PREFIX>RBTree() *<GLOBAL_NAME_PREFIX>RBTree {
	return &<GLOBAL_NAME_PREFIX>RBTree{}
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Init(bigFirst bool) {
	this.header.parent = nil
	this.header.left = nil
	this.header.right = nil
	this.header.color = RBTREE_RED
	this.size = 0
	this.cmp.CreateByBool(bigFirst)
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) insertUnique(d <GLOBAL_NAME_PREFIX>RBTreeNodeData) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	x, y, comp := this.root(), &this.header, true
	for x != nil {
		y = x
		comp = this.cmp.F(d.key, x.val.key)
		if comp {
			x = x.left
		} else {
			x = x.right
		}
	}
	if comp {
		if y == this.topLeft() {
			return this.insert(x, y, d)
		} else {
			y = y.prev()
		}
	}
	if this.cmp.F(y.val.key, d.key) {
		return this.insert(x, y, d)
	}
	return nil
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) insertEqual(d <GLOBAL_NAME_PREFIX>RBTreeNodeData) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	x, y := this.root(), &this.header
	for x != nil {
		y = x
		if this.cmp.F(d.key, x.val.key) {
			x = x.left
		} else {
			x = x.right
		}
	}
	return this.insert(x, y, d)
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) insert(_x, _y *<GLOBAL_NAME_PREFIX>RBTreeNode, d <GLOBAL_NAME_PREFIX>RBTreeNodeData) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	x, y, z := _x, _y, this.createNode(d)
	if y == &this.header || x != nil || this.cmp.F(d.key, y.val.key) {
		y.left = z
		if y == &this.header {
			this.header.parent = z
			this.header.right = z
		} else if y == this.header.left {
			this.header.left = z
		}
	} else {
		y.right = z
		if y == this.header.right {
			this.header.right = z
		}
	}
	z.parent = y
	z.left, z.right = nil, nil
	z.rebalence(&this.header.parent)
	this.size++
	return z
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Size() int {
	return this.size
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Empty() bool {
	return this.root() == nil
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Visitor(node *<GLOBAL_NAME_PREFIX>RBTreeNode) *<GLOBAL_NAME_PREFIX>RBTreeNodeVisitor {
	return nil
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Begin() *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return this.topLeft()
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) End() *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return &this.header
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Clear() {
	this.Init(this.cmp == CMPGreater)
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Insert(d <GLOBAL_NAME_PREFIX>RBTreeNodeData) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return nil
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Remove(d <GLOBAL_NAME_PREFIX>RBTreeNodeData) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return nil
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Erase(n *<GLOBAL_NAME_PREFIX>RBTreeNode) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return nil
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) LowerBound(d <GLOBAL_NAME_PREFIX>RBTreeNodeData) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return nil
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) UpperBound(d <GLOBAL_NAME_PREFIX>RBTreeNodeData) *<GLOBAL_NAME_PREFIX>RBTreeNode {
	return nil
}

func (this *<GLOBAL_NAME_PREFIX>RBTree) Find(key <KEY_TYPE>) (r *<GLOBAL_NAME_PREFIX>RBTreeNode) {
	var y *<GLOBAL_NAME_PREFIX>RBTreeNode = nil
	for n := this.root(); n != nil; {
		if !this.cmp.F(n.val.key, key) {
			y, n = n, n.left
		} else {
			n = n.right
		}
	}
	if y != nil && !this.cmp.F(key, y.val.key) {
		r = y
	}
	return
}

