import 'dart:convert';
import 'dart:developer';

import 'package:bloc_experiment/api_response.dart';
import 'package:bloc_experiment/apis_service.dart';
import 'package:bloc_experiment/data/request/booking_request.dart';
import 'package:bloc_experiment/data/request/login_request.dart';
import 'package:bloc_experiment/data/request/otp_request.dart';
import 'package:bloc_experiment/data/request/select_booking_request.dart';
import 'package:dio/dio.dart';

class Repository {
  ApiService? apiService;

  Repository() {
    apiService = ApiService();
  }
  Future<ApiResponse> performLogin(LoginRequest loginRequest) async {
    try {
      final response = await apiService?.dio.post("public/api/login",
          options: Options(
            responseType: ResponseType.json,
            contentType: "application/json",
          ),
          data: json.encode(loginRequest.toJson()));
      if (response!.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(response.data);
      } else {
        return ApiResponse.error(response.data);
      }
    } on DioError catch (e) {
      log("here is the exception -> $e");
      if (e.response?.statusCode == 400) {
        return ApiResponse.failure(e.response?.data);
      }
      return ApiResponse.failure(e.response?.data);
    }
  }

  Future<ApiResponse> performOtpVerification(OtpRequest otpRequest) async {
    try {
      final response = await apiService?.dio.post("/public/api/verify",
          options: Options(
            responseType: ResponseType.json,
            contentType: "application/json",
          ),
          data: json.encode(otpRequest.toJson()));
      if (response!.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(response.data);
      } else {
        return ApiResponse.error(response.data);
      }
    } on DioError catch (e) {
      log("here is the exception -> $e");
      if (e.response?.statusCode == 400) {
        return ApiResponse.failure(e.response?.data);
      }
      return ApiResponse.failure(e.response?.data);
    }
  }

  Future<ApiResponse> performBooking(BookingRequest bookingRequest,String token) async {
    try {

      final response = await apiService?.dio.post("/public/api/book",
          options: Options(
            responseType: ResponseType.json,
            contentType: "application/json",
            headers: {
              "Authorization" : "Bearer ${token}"
            }
          ),
          data: json.encode(bookingRequest.toJson()));
      if (response!.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(response.data);
      } else {
        return ApiResponse.error(response.data);
      }
    } on DioError catch (e) {
      log("here is the exception -> $e");
      if (e.response?.statusCode == 400) {
        return ApiResponse.failure(e.response?.data);
      }
      return ApiResponse.failure(e.response?.data);
    }
  }

  Future<ApiResponse> getBookingSlots(SelectbookingRequest selectbookingRequest) async {
    try {
      final response = await apiService?.dio.post("/public/api/book/getBookList",
          options: Options(
              responseType: ResponseType.json,
              contentType: "application/json",
          ),
          data: json.encode(selectbookingRequest.toJson()));
      if (response!.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(response.data);
      } else {
        return ApiResponse.error(response.data);
      }
    } on DioError catch (e) {
      log("here is the exception -> $e");
      if (e.response?.statusCode == 400) {
        return ApiResponse.failure(e.response?.data);
      }
      return ApiResponse.failure(e.response?.data);
    }
  }

}
