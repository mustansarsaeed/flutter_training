import 'dart:async';

class Cake {}

class Order {
  String type;
  Order(this.type);
}

void main() {
  final controller = new StreamController();
  final order = new Order('chocolate');
  final baker =
      new StreamTransformer.fromHandlers(handleData: (cakeType, sink) {
    if (cakeType == 'chocolate') {
      sink.add(new Cake());
    } else {
      sink.addError('Undefined type!');
    }
  });

  controller.sink.add(order);

  controller.stream.map((order) => order.type).transform(baker).listen(
        (cake) => print('Cake created $cake'),
        onError: (error) => print(error),
      );
}
