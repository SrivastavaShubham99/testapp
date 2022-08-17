

class BaseResponse<T>{
  T? data;
  bool? isSuccess;

  BaseResponse.success(dynamic dataResponse,bool response){
    data=dataResponse;
    isSuccess=response;
  }

  BaseResponse.failure(dynamic dataResponse,bool response){
    data=dataResponse;
    isSuccess=response;
  }

}

