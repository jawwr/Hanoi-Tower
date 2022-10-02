class MyStack<T extends Object> {
  List<T> elements = [];

  MyStack.copyOfList(List<T> copyList) {
    elements = List.of(copyList);
    length = copyList.length;
  }

  MyStack.copyOfStack(MyStack<T> copyStack) {
    elements = List.of(copyStack.elements);
    length = copyStack.length;
  }

  int length = 0;

  bool get isEmpty => length == 0;

  MyStack();

  void push(T newElement) {
    length++;
    elements.insert(0, newElement);
  }

  T head() {
    return elements.first;
  }

  T tail() {
    return elements.last;
  }

  T? pop() {
    if (length == 0) {
      return null;
    }
    T firstElem = head();
    elements.remove(firstElem);
    return firstElem;
  }
}
