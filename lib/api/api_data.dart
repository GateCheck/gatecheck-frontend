enum DataStatus { Success, Unauthorized, Failure }

class ApiData<T> {
  DataStatus status;
  T data;

  ApiData(T Data, DataStatus Status)
      : data = Data,
        status = Status;
}
