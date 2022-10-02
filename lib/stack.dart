class Stack<T extends Object>{
  late List<T> _elements;

  set elements(List<T> value) {
    _elements = value;
  }

  int length = 0;

  bool get isEmpty => length == 0;

  List<T> get elements => _elements;

  Stack();

  static Stack copyOfList(List copyList) {
    Stack newStack = Stack();
    for (var elem in copyList) {
      newStack.push(elem);
    }
    return newStack..length = copyList.length;
  }

  static Stack copyOfStack(Stack copyStack) {
    Stack newStack = Stack()
      ..elements = copyStack.elements
      ..length = copyStack.length;
    return newStack;
  }

  void push(T newElement) {
    _elements.insert(0, newElement);
  }
  T head(){
    return _elements.first;
  }

  T tail(){
    return _elements.last;
  }

  T? pop() {
    if (length == 0) {
      return null;
    }
    T firstElem = head();
    _elements.remove(firstElem);
    return firstElem;
  }
}
