enum ENV {
  DESA,
  QA,
  PROD,
  DEMO,
}

extension Environment on ENV {
  static ENV type = ENV.DESA;
  static Map<String, dynamic> get appConfig {
    switch (type) {
      case ENV.DESA:
        return {
          "enviroment": "DESAROLLO",
          // "baseUrl": "http://localhost/backend_tasking_v1NETFrameworkSQLServer/General",
          "baseUrl": "http://192.168.100.8/backend_tasking_v1NETFrameworkSQLServer/General",
          "connectTimeout": 600000,
          "receiveTimeout": 600000,
          "sendTimeout": 600000,
        };
      case ENV.QA:
        return {
          "enviroment": "QA",
          "baseUrl": "https://app.task-ing.com/ApiTaskingQa/General",
          "connectTimeout": 600000,
          "receiveTimeout": 600000,
        };
      case ENV.PROD:
        return {
          "enviroment": "PRODUCCIÓN",
          "baseUrl": 'https://app.task-ing.com/api_task_kanban_prod/General', 
          "connectTimeout": 600000,
          "receiveTimeout": 600000,
        };
       case ENV.DEMO:
        return {
          "enviroment": "DEMO",
          "baseUrl": 'https://app.task-ing.com/api_task_demo/General', 
          "connectTimeout": 600000,
          "receiveTimeout": 600000,
        };
      default:
        return {
          "": "",
        };
    }
  }
}
