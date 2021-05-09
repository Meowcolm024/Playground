class Node:
    def __init__(self, v, n=None):
        self.value = v
        self.next = n

    def __str__(self):
        return f'{self.value} {"" if self.next is None else self.next}'


def cons(value, node: Node) -> Node:
    return Node(value, node)


def head(node: Node):
    return None if node is None else node.value


def tail(node: Node) -> Node:
    return None if node is None else node.next


def append(xs: Node, ys: Node) -> Node:
    return ys if xs is None else cons(head(xs), append(tail(xs), ys))


def fromList(xs: list) -> Node:
    if xs == []:
        return None
    else:
        return cons(xs[0], fromList(xs[1:]))


def partition(f, l: Node, r: Node, xs: Node) -> (Node, Node):
    if xs is None:
        return (l, r)
    else:
        p = head(xs)
        y = tail(xs)
        if f(p):
            return partition(f, cons(p, l), r, y)
        else:
            return partition(f, l, cons(p, r), y)


def qsort(xs: Node) -> Node:
    if xs is None:
        return None
    else:
        p = head(xs)
        y = tail(xs)
        (l, r) = partition(lambda t: t <= p, None, None, y)
        return append(append(qsort(l), Node(p)), qsort(r))


print(qsort(fromList([4, 3, 6, 9, 8, 0, 7, 1, 2])))
