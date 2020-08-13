import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectDB {
  var settings = new ConnectionSettings(
      host: '139.180.212.45',
      port: 3306,
      user: 'trial',
      password: 'trial123',
      db: 'sistemtiket');

  Future<bool> register(
      String name, String email, String telepon, String password) async {
    var conn = await MySqlConnection.connect(settings);
    return await conn
        .query('select email from user where email = ?', [email]).then((value) {
      try {
        value.first.cast();
        return false;
      } catch (error) {
        conn.query(
            'insert into user (nama,email,telepon,password,tiket) value ("$name","$email","$telepon","$password","0")');
        return true;
      }
    });
  }

  Future<bool> auth(String email, String password) async {
    var conn = await MySqlConnection.connect(settings);
    var prefs = await SharedPreferences.getInstance();
    print('$email : $password');
    var results =
        await conn.query('select password from user where email = ?', [email]);
    try {
      if (results.first.cast()[0].toString() == password) {
        prefs.setBool('islogin', true);
        prefs.setString('user', email);
        print('login berhasil');
        return true;
      } else
        return false;
    } catch (error) {
      print('login gagal');
      return false;
    }
  }

  Future<void> updateName(String name, String email) async {
    var conn = await MySqlConnection.connect(settings);
    await conn.query('update user set nama = ? where email = ?', [name, email]);
  }

  Future<void> updatePhone(String phone, String email) async {
    var conn = await MySqlConnection.connect(settings);
    await conn
        .query('update user set telepon = ? where email = ?', [phone, email]);
  }

  Future<bool> updatePassword(
      String email, String oldpass, String newpass) async {
    var conn = await MySqlConnection.connect(settings);

    return await auth(email, oldpass).then((value) async {
      if (value) {
        var results = await conn.query(
            'update user set password = ? where email = ?', [newpass, email]);
        print(results);
        return true;
      } else
        return false;
    });
  }

  Future<List<dynamic>> userdata(String email) async {
    var conn = await MySqlConnection.connect(settings);
    var results = await conn
        .query('select nama,tiket from user where email = ?', [email]);
    // var results = await conn
    //     .query('select nama,saldo,tiket from user where email = ?', [email]);
    print(results);
    return results.toList()[0];
  }

  Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('islogin', false);
    prefs.setString('user', '');
  }

  Future<List<dynamic>> listDokter(String poli) async {
    var conn = await MySqlConnection.connect(settings);
    var query = await conn.query('select dokter,harga from $poli');
    return query.cast().toList();
  }

  Future<bool> getTicket(
      String poli, String dokter, String email, int harga) async {
    var conn = await MySqlConnection.connect(settings);
    var _kuota =
        await conn.query('select kuota from $poli where dokter = ?', [dokter]);
    int kuota = _kuota.toList()[0]['kuota'];
    if (kuota > 0) {
      await conn.query(
          'update $poli set kuota = kuota - 1 where dokter = ?', [dokter]);
      var lastData = await conn.query('select waktu from history order by id desc limit 1');
      try{
        int timestamp = lastData.toList()[0]['waktu'];
        var diff = DateTime.now().millisecondsSinceEpoch - timestamp;
        var waktu = DateTime.fromMillisecondsSinceEpoch(timestamp).add(Duration(minutes: 30));
        var _waktu = waktu.millisecondsSinceEpoch+diff;
        var history = await conn.query(
          'insert into history (email,dokter,harga,waktu) value ("$email","$dokter","$harga","$_waktu")');
      // var timestamp  = await conn.query('select waktu from history order by id desc limit 1');
      // print(DateTime.now().millisecondsSinceEpoch);
      await conn.query(
          'update user set tiket=${history.insertId} where email = ?', [email]);
      }
      catch(e){
        int waktu = DateTime.now().millisecondsSinceEpoch;
        print(waktu);
        var history = await conn.query(
          'insert into history (email,dokter,harga,waktu) value ("$email","$dokter","$harga","$waktu")');
        await conn.query(
          'update user set tiket=${history.insertId} where email = ?', [email]);
        
      }
      return true;
    } else
      return false;
  }

  Future<List<dynamic>> getHistory(String email) async {
    var conn = await MySqlConnection.connect(settings);
    var query = await conn.query(
        'select id,waktu,dokter,harga from history where email = ?', [email]);
    // List<String> time = query.toList()[0]['waktu'].toString().split('.');
    // print(DateTime.parse(time[0]));

    return query.toList();
  }

  Future<void> cancelOrder(
    String email,
    String id,
    String dokter,
    int harga,
  ) async {
    var conn = await MySqlConnection.connect(settings);
    await conn.query('delete from history where id = ?', [id]);
    await conn.query(
        'update user set saldo = saldo+? , tiket = 0 where email = ?',
        [harga, email]);
  }
}
