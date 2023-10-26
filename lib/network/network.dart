import 'package:http/http.dart' as http;
import 'dart:convert';

var host = 'http://203.252.240.71:8000/';

class Network {
  // getJsonData() async {
  //   var url = Uri.parse(this.);
  //   // http.Response response = await http.get(Uri.parse(url));
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     print('응답');
  //   } else {
  //     print('노응답');
  //   }

  //   return json.decode(response.body);
  // }

  Future<dynamic> mainPage(email) async {
    late dynamic result;

    var url = Uri.parse('$host/mainPage');

    http.Response response = await http.post(url, body: {'email': email});
    result = await json.decode(response.body);
    return result;
  }

  Future<String> changePassword(data1, data2) async {
    late String result;
    var url = Uri.parse('$host/changePassword');

    http.Response response = await http.post(
      url,
      body: {
        'userEmail': data1,
        'inputPassword': data2,
      },
    );
    result = await json.decode(response.body)['result'];
    return result;
  }

  Future<String> Register(data1, data2, data3) async {
    var url = Uri.parse('$host/register');
    late String result;
    // http.Response response = await http.get(Uri.parse(url));

    http.Response response = await http.post(
      url,
      body: {
        'userEmail': data1,
        'userPassword': data2,
        'userNickname': data3,
      },
    );

    result = await json.decode(response.body)['result'];

    return result;
  }

  Future<String> Login(data1, data2) async {
    var url = Uri.parse('$host/login');
    String result = '';

    http.Response response = await http.post(
      url,
      body: {
        'userEmail': data1,
        'userPassword': data2,
      },
    );
    result = json.decode(utf8.decode(response.bodyBytes))['result'];
    return result;
  }

  Future<bool> changeEmail(data1, data2) async {
    var url = Uri.parse('$host/changeEmail');
    late bool result;
    http.Response response = await http.post(
      url,
      body: {
        'email': data1,
        'newEmail': data2,
      },
    );

    result = json.decode(response.body)['result'];
    return result;
  }

  Future<bool> changePass(data1, data2) async {
    var url = Uri.parse('$host/changePassword');
    late bool result;
    http.Response response = await http.post(
      url,
      body: {
        'email': data1,
        'password': data2,
      },
    );

    result = json.decode(response.body)['result'];
    return result;
  }

  Future<bool> changeNickname(data1, data2) async {
    var url = Uri.parse('$host/changeNick');
    late bool result;
    http.Response response = await http.post(
      url,
      body: {
        'email': data1,
        'changeNick': data2,
      },
    );

    result = json.decode(utf8.decode(response.bodyBytes))['result'];
    return result;
  }

  Future<bool> deleteHistory(email) async {
    var url = Uri.parse('$host/deleteHistory');
    late bool result;
    http.Response response = await http.post(
      url,
      body: jsonEncode({'email': email}),
      headers: {'content-type': 'application/json'},
    );
    result = json.decode(utf8.decode(response.bodyBytes))['result'];
    return result;
  }

  Future<bool> deleteUser(email) async {
    var url = Uri.parse('$host/deleteUser');
    late bool result;
    http.Response response = await http.post(
      url,
      body: jsonEncode({'email': email}),
      headers: {'content-type': 'application/json'},
    );
    result = json.decode(utf8.decode(response.bodyBytes))['result'];
    return result;
  }

  Future<dynamic> Detection(data1, data2, data3, data4) async {
    var url = Uri.parse('$host/detection');
    late var result;
    print(data4);
    http.Response response = await http.post(
      url,
      body: jsonEncode({
        'Y': data1,
        'U': data2,
        'V': data3,
        'result': data4,
      }),
      headers: {'content-type': 'application/json'},
    );
    result = json.decode(utf8.decode(response.bodyBytes));

    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<bool> detailCart(email, name, count, total) async {
    var url = Uri.parse('$host/detailCart');
    late bool result;

    http.Response response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'product_name': name,
        'product_count': count,
        'product_total': total,
      }),
      headers: {'content-type': 'application/json'},
    );
    result = json.decode(utf8.decode(response.bodyBytes))['result'];

    return result;
  }

  Future<dynamic> checkShopping(email, date) async {
    var url = Uri.parse('$host/calendarLoad');
    late dynamic result;
    print(email);
    print(date);
    http.Response response = await http.post(
      url,
      body: {
        'email': email,
        'date': date,
      },
    );
    result = json.decode(utf8.decode(response.bodyBytes));

    return result;
  }

  Future<void> CartMakeList(
      email, productName, productPrice, productAmount, totalPrice) async {
    var url = Uri.parse('$host/cartMakeList');

    var body = jsonEncode({
      'email': email,
      'product_name': productName,
      'product_price': productPrice,
      'product_amount': productAmount,
      'total_price': totalPrice,
    });
    http.Response response = await http
        .post(url, body: body, headers: {'content-type': 'application/json'});
  }

  Future<void> calendarDelete(idenNum) async {
    var url = Uri.parse('$host/calendarDelete');
    http.Response response = await http.post(url,
        body: jsonEncode({'iden_num': idenNum}),
        headers: {'content-type': 'application/json'});
  }

  Future<dynamic> calendarLoadDetail(idenNum) async {
    var url = Uri.parse('$host/calendarLoadDetail');
    http.Response response = await http.post(url,
        body: jsonEncode({'iden_num': idenNum}),
        headers: {'content-type': 'application/json'});
    return json.decode(utf8.decode(response.bodyBytes))['result'];
  }
}
