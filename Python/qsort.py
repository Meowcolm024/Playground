class Node:
    def __init__(self, v, n=None):
        self.value = v
        self.next = n

    def __str__(self):
        return f'{self.value} {"" if self.next is None else self.next}'


def head(node: Node):
    return None if node is None else node.value


def tail(node: Node) -> Node:
    return None if node is None else node.next


def append(xs: Node, ys: Node) -> Node:
    return ys if xs is None else Node(head(xs), append(tail(xs), ys))


def partition(f, l: Node, r: Node, xs: Node) -> (Node, Node):
    if xs is None:
        return (l, r)
    else:
        p = head(xs)
        y = tail(xs)
        if f(p):
            return partition(f, Node(p, l), r, y)
        else:
            return partition(f, l, Node(p, r), y)


def qsort(xs: Node) -> Node:
    if xs is None:
        return None
    else:
        p = head(xs)    # pivot
        y = tail(xs)    # the rest of the list
        (l, r) = partition(lambda t: t <= p, None, None, y)
        return append(append(qsort(l), Node(p)), qsort(r))


def fromList(xs: list) -> Node:
    return None if xs == [] else Node(xs[0], fromList(xs[1:]))

print(qsort(fromList([4, 3, 6, 9, 8, 0, 7, 1, 2, 5])))
