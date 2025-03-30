class SList:
    class Node:
        def __init__(self, item, link):
            self.item = item
            self.next = link

    def __init__(self):
        print("나는 SList의 Constructor method")
        self.head = None
        self.size = 0
    def isEmpty(self):
        return self.size == 0

    def insert_front(self, item):
        if self.isEmpty():
            self.head = self.Node(item, None)
        else:
            self.head = self.Node(item,
                                   self.head)
        self.size += 1

    def insert_after(self, item, p):
        p.next = self.Node(item, p.next)
        self.size += 1



    def showList(self):
        p = self.head
        while p:
            if p.next is not None:
                print(p.item , "=>", end="")
            else:
                print(p.item)

            p = p.next

if __name__ == "__main__":
    s = SList()
    s.insert_front("mango")
    s.insert_front("apple")
    s.showList()
    s.insert_after("cherry" , s.head.next)
    s.showList()