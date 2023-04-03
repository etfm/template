
class LogUtils {

  //是否输入日志标识
  static bool _isLog = true;
  static String _logFlag = "jl_police";

  static void init({bool islog = false,String logFlag ="jl_police"}){
    _isLog = islog;
    _logFlag = logFlag;
  }


  static void e(String message){

    if(_isLog){
      print("$_logFlag | $message");
    }
  }

}